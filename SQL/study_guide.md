# SQL & BigQuery Refresher: Course Study Guide

This document provides a concise, bullet-point summary of the core concepts, Python client API usage, and SQL structures from the Kaggle "Getting Started with SQL and BigQuery" course.

---

## Chapter 1: Getting Started with SQL and BigQuery
* **BigQuery Organization**: `Project` ➔ `Dataset` ➔ `Table`.
* **API Objects**:
  * `client = bigquery.Client()`: Establish a GCP connection.
  * `dataset_ref = client.dataset(dataset_id, project=project_id)`: Point to a dataset.
  * `dataset = client.get_dataset(dataset_ref)`: Retrieve dataset metadata.
  * `tables = list(client.list_tables(dataset))`: List tables in a dataset.
  * `table_ref = dataset_ref.table(table_id)`: Point to a specific table.
  * `table = client.get_table(table_ref)`: Retrieve table metadata and schema.
* **Schema Fields**: Contains `name` (column name), `field_type` (DATETIME, STRING, FLOAT, etc.), and `mode` (NULLABLE, REQUIRED).
* **Cost-Efficient Preview**: Use `client.list_rows(table, max_results=5).to_dataframe()` to inspect rows without scanning data (avoids SQL query costs).

---

## Chapter 2: Select, From & Where
* **Basics**:
  * `SELECT`: Specifies columns to retrieve.
  * `FROM`: Identifies the dataset and table (`project.dataset.table`).
  * `WHERE`: Filters rows based on conditional expressions (e.g., `WHERE country = 'US'`).
* **Query Workflow**:
  ```python
  # Define query text
  query = "SELECT col1 FROM `project.dataset.table` WHERE col2 = 'value'"
  # Run query and convert to Pandas DataFrame
  df = client.query(query).to_dataframe()
  ```
* **Cost Safety (Dry Run)**:
  * Estimate data scanned *before* running the query:
    ```python
    safe_config = bigquery.QueryJobConfig(dry_run=True, use_query_cache=False)
    query_job = client.query(query, job_config=safe_config)
    print(f"This query will process {query_job.total_bytes_processed} bytes.")
    ```
* **Query Limit Safety**:
  * Block queries that exceed a maximum byte limit:
    ```python
    # Cancel query if it scans more than 1 GB (10^9 bytes)
    limit_config = bigquery.QueryJobConfig(maximum_bytes_billed=10**9)
    df = client.query(query, job_config=limit_config).to_dataframe()
    ```

---

## Chapter 3: Group By, Having & Count
* **Aggregations**:
  * `COUNT()`: Counts the number of values/rows.
  * `SUM()`, `AVG()`, `MIN()`, `MAX()`: Performs numerical reductions.
* **Grouping**:
  * `GROUP BY`: Directs BigQuery to group rows sharing the same value in specified columns.
  * *Rule*: Any column in `SELECT` that is NOT inside an aggregate function **must** be declared in `GROUP BY`.
* **Filtering Aggregations**:
  * `HAVING`: Filters groups *after* aggregation (e.g., `HAVING COUNT(id) > 100`).
  * *Note*: `WHERE` filters individual rows *before* aggregation; `HAVING` filters groups *after* aggregation.

---

## Chapter 4: Order By
* **Sorting**:
  * `ORDER BY`: Sorts the result set by one or more columns.
  * `ASC` (default): Ascending order (lowest to highest, A to Z).
  * `DESC`: Descending order (highest to lowest, Z to A).
* **Dates and Times**:
  * `DATE`: Format `YYYY-MM-DD`.
  * `DATETIME` / `TIMESTAMP`: Includes hour, minute, and second.
  * BigQuery date extraction functions: `EXTRACT(DAY FROM date_col)`, `EXTRACT(YEAR FROM date_col)`, `EXTRACT(DAYOFWEEK FROM date_col)`.

---

## Chapter 5: As & With (CTEs)
* **Aliasing**:
  * `AS`: Renames a column or table for readability (e.g., `SELECT COUNT(id) AS total_records`).
* **Common Table Expressions (CTEs)**:
  * `WITH ... AS (...)`: Defines a temporary, named result set that can be queried like a table within the main query.
  * Key benefits: Breaks down complex queries into logical steps, enhances readability, and aids debugging.
  * **Syntax**:
    ```sql
    WITH TermTable AS (
        SELECT col1, col2 
        FROM `project.dataset.table` 
        WHERE col3 = 'criteria'
    )
    SELECT AVG(col1) 
    FROM TermTable
    ```

---

## Chapter 6: Joining Data
* **Combining Tables**:
  * `JOIN` / `INNER JOIN` (default): Returns rows with matching values in both tables.
  * `LEFT JOIN`: Returns all rows from the left table, plus matched rows from the right table (unmatched right rows become `NULL`).
  * `RIGHT JOIN`: Returns all rows from the right table, plus matched rows from the left table.
  * `FULL JOIN`: Returns all rows when there is a match in either left or right table.
* **Syntax**:
  ```sql
  SELECT t1.col1, t2.col2
  FROM `project.dataset.table1` AS t1
  INNER JOIN `project.dataset.table2` AS t2
    ON t1.shared_id = t2.shared_id
  ```
