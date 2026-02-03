Introduction

My data pipeline is brittle. 

My data is not version controlled.

My data is not testable.

My data does not have documentation.

ETL to ELT

Traditionally, data pipelines consisted of Extract, Transform, Load (ETL). Source data was converted in the "transform" step to meet requirements, then loaded into the warehouse.
In the mid-2010s, Amazon and others introduced an infrastructure change that shook up the data landscape: the separation of compute and storage. Services like Amazon Redshift and Snowflake made storage cheap and scalable. This enabled flipping TL to LT—**Extract, Load, Transform (ELT)**. Since storage was inexpensive, you could load raw data first, then transform it directly within the warehouse for downstream applications.

New Age Orchestrators

dbt emerged to add software engineering practices to this new ELT paradigm. Version control, logging, and testing were largely missing from the data world. dbt launched this mindset shift in data engineering.

Software Engineering for Data

dbt is a tool that enables data teams to apply software engineering best practices to analytics engineering.
- Build tool
  It is the Maven/Gradle (Java), npm (JavaScript), or Cargo (Rust) equivalent for the data world.
- Doc generation
- Testing
- Version control

Running dbt

Step 1: Initialize

```bash
dbt init my_dbt_project
cd my_dbt_project
```

This creates a standard project structure:

```
blog_example/
├── dbt_project.yml
├── packages.yml
├── models/
│   ├── sources.yml
│   ├── staging/
│   │   ├── schema.yml
│   │   ├── stg_customers.sql
│   │   └── stg_orders.sql
│   └── marts/
│       └── core/
│           └── customers_orders.sql
├── macros/
├── tests/
├── seeds/
├── snapshots/
├── analyses/
```

Key Files & Directories

1. **dbt_project.yml**
   This contains the root-level folder structure and configurations for the project.

2. **packages.yml**
   This contains the packages that are used in the project. There is package-lock.yml that uses the software engineering practice of pinning requiring dependencies with their appropriate versions. (Like go.mod in golang package-lock.json in nodejs).

3. **models**
   This contains the models that are used in the project.
   
   Example Model:
   ```jinja
   {{ config(materialized='table') }}

   select id, name, email, bio, current_timestamp as created_at
   from {{ ref('authors') }}
   ```
   
   - schema.yml - This contains the schema for the models.
   - *.sql - This contains the models that are used in the project. Uses jinja template to have placeholders

4. **macros/**
   Reusable SQL snippets (functions) that eliminate code duplication across models.

5. **tests/**
   Custom data quality tests beyond the built-in schema tests. Enables test-driven development for data.
   
   **Two Types of test:**
   
   1. Schema Tests (defined in schema.yml):
      - not_null: Column has no NULL values
      - unique: Column values are distinct
      - relationships: Foreign key integrity
      - accepted_values: Column values in allowed set
   
   2. Singular Tests (`*.sql` files):
      - Custom SQL queries that return 0 rows if test passes
      
      Example: `SELECT * FROM customers WHERE email NOT LIKE '%@%'`

6. **seeds/**
   Static CSV files loaded into the warehouse. Ideal for small reference data (e.g., country codes, mappings).

7. **snapshots/**
   This contains the snapshots that are used in the project. Useful for tracking changes in data over time.

8. **analyses/**
   Ad-hoc exploratory queries. Compiled but not scheduled in production pipelines.

Essential Commands

```bash
dbt run                 # Execute all models
dbt test                # Run data quality tests
dbt build               # Run models and tests in one command
dbt seed                # Load CSV files from seeds/ into warehouse
dbt snapshot            # Execute snapshot logic for SCD tracking
dbt docs generate       # Generate project documentation
dbt docs serve          # Serve docs on localhost:8080
dbt source freshness    # Check source data staleness
dbt clean               # Remove compiled files in target/
```

Step 1: Install database connector

```bash
uv pip install dbt-core dbt-duckdb
```

Step 2: dbt seed

```
❯ dbt seed
14:45:35  Running with dbt=1.11.2
14:45:36  Registered adapter: duckdb=1.10.0
14:45:36  [WARNING]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 1 unused configuration paths:
- models.blog_example.example
14:45:36  Found 5 data tests, 2 seeds, 3 models, 2 sources, 804 macros
14:45:36  
14:45:36  Concurrency: 1 threads (target='dev')
14:45:36  
14:45:36  1 of 2 START seed file main.authors ............................................ [RUN]
14:45:36  1 of 2 OK loaded seed file main.authors ........................................ [INSERT 2 in 0.06s]
14:45:36  2 of 2 START seed file main.blog_posts ......................................... [RUN]
14:45:36  2 of 2 OK loaded seed file main.blog_posts ..................................... [INSERT 5 in 0.02s]
14:45:36  
14:45:36  Finished running 2 seeds in 0 hours 0 minutes and 0.18 seconds (0.18s).
14:45:36  
14:45:36  Completed successfully
14:45:36  
14:45:36  Done. PASS=2 WARN=0 ERROR=0 SKIP=0 NO-OP=0 TOTAL=2
```

Step 3: dbt run

```
14:30:18  Running with dbt=1.11.2
14:30:18  Registered adapter: duckdb=1.10.0
14:30:18  [WARNING]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 1 unused configuration paths:
- models.blog_example.example
14:30:18  Found 5 data tests, 2 seeds, 3 models, 2 sources, 804 macros
14:30:18  
14:30:18  Concurrency: 1 threads (target='dev')
14:30:18  
14:30:18  1 of 3 START sql table model main.stg_authors .................................. [RUN]
14:30:18  1 of 3 OK created sql table model main.stg_authors ............................. [OK in 0.08s]
14:30:18  2 of 3 START sql table model main.stg_blog_posts ............................... [RUN]
14:30:19  2 of 3 OK created sql table model main.stg_blog_posts .......................... [OK in 0.03s]
14:30:19  3 of 3 START sql table model main.blog_posts_enhanced .......................... [RUN]
14:30:19  3 of 3 OK created sql table model main.blog_posts_enhanced ..................... [OK in 0.03s]
14:30:19  
14:30:19  Finished running 3 table models in 0 hours 0 minutes and 0.26 seconds (0.26s).
14:30:19  
14:30:19  Completed successfully
14:30:19  
14:30:19  Done. PASS=3 WARN=0 ERROR=0 SKIP=0 NO-OP=0 TOTAL=3
```

Step 4: dbt test

```
❯ dbt test
14:46:11  Running with dbt=1.11.2
14:46:11  Registered adapter: duckdb=1.10.0
14:46:12  [WARNING]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 1 unused configuration paths:
- models.blog_example.example
14:46:12  Found 5 data tests, 2 seeds, 3 models, 2 sources, 804 macros
14:46:12  
14:46:12  Concurrency: 1 threads (target='dev')
14:46:12  
14:46:12  1 of 5 START test assert_author_exists ......................................... [RUN]
14:46:12  1 of 5 PASS assert_author_exists ............................................... [PASS in 0.03s]
14:46:12  2 of 5 START test assert_positive_view_count ................................... [RUN]
14:46:12  2 of 5 PASS assert_positive_view_count ......................................... [PASS in 0.01s]
14:46:12  3 of 5 START test assert_published_posts_have_content .......................... [RUN]
14:46:12  3 of 5 PASS assert_published_posts_have_content ................................ [PASS in 0.01s]
14:46:12  4 of 5 START test assert_slug_format ........................................... [RUN]
14:46:12  4 of 5 PASS assert_slug_format ................................................. [PASS in 0.02s]
14:46:12  5 of 5 START test assert_unique_email .......................................... [RUN]
14:46:12  5 of 5 PASS assert_unique_email ................................................ [PASS in 0.01s]
14:46:12  
14:46:12  Finished running 5 data tests in 0 hours 0 minutes and 0.18 seconds (0.18s).
14:46:12  
14:46:12  Completed successfully
14:46:12  
14:46:12  Done. PASS=5 WARN=0 ERROR=0 SKIP=0 NO-OP=0 TOTAL=5
```

Documentation

Use `dbt docs generate` to generate the documentation for your project. This creates a target folder from which you can serve the documentation using `dbt docs serve`.



