# SQL and BigQuery Refresher

This project accompanies the [Kaggle Getting Started with SQL and BigQuery](https://www.kaggle.com/code/dansbecker/getting-started-with-sql-and-bigquery) course. It is structured to run queries locally using Python and Jupyter Notebooks while maintaining software engineering best practices.

## Directory Structure

```text
SQL/
├── requirements.txt         # Project dependencies
├── README.md                # Setup & Authentication instructions
├── check_connection.ipynb   # Verification notebook
└── chapters/                # Course chapters containing notebooks and raw SQL
    ├── 01_getting_started/
    ├── 02_select_from_where/
    ├── 03_group_by_having_count/
    ├── 04_order_by/
    ├── 05_as_with/
    └── 06_joining_data/
```

---

## Setup & Installation

### 1. Python Environment

Make sure your virtual environment is active and dependencies are installed:

```bash
# Activate virtual environment
source ../.venv/bin/activate

# Verify dependencies are installed
pip install -r requirements.txt
```

### 2. Google Cloud Platform (GCP) Authentication

To run queries locally, the Google Cloud client libraries must be authenticated with a GCP Project.

#### Option A: Using Google Cloud CLI (Recommended for Mac)

This is the cleanest approach because it avoids downloading sensitive credentials files to your local drive.

1. **Install the Google Cloud CLI** (using Homebrew on macOS):
   ```bash
   brew install --cask google-cloud-sdk
   ```
2. **Initialize gcloud**:
   ```bash
   gcloud init
   ```
   Follow the prompts to log into your Google Account and select/create a project.
3. **Configure Application Default Credentials (ADC)**:
   ```bash
   gcloud auth application-default login
   ```
   This will open a browser window. Once you authenticate, your local environment is fully configured!

# DS-AI-roadmap
