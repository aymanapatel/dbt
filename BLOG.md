

# ETL to ELT

Insert gemini pro here


Traditionally, data pipelines consisted of Extract. transform Load.


Source data was converted in the "transform" step to the requirements.
It was then loaded.
But in mid-2010a, amazon and others came with a infrastructure change that shook up the data landscape. It was able to segregate compute and storage.
Snowflake, Amazon then came up with flipping TL to LT. Since storage was segregated and cheap, you could load up into storage before transforming it for downstream applications.

## New age orchestrators 






Dbt then came to add software engineering practices 

Practices such as version control. Logging and testing is something that was missing in the data world. Dbt was used to launch that mindset in the data engineering world.


It is the Maven/Gradle(Java) or npm(JavaScript) or cargo(Rust) equivalent of the data world.

# Running 


## Step 


Initialize by using


```shell
dbt init
```

It creates a project structure like this



```shell
dbt_project/
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

### `dbt_project.yml`

This contains the root-level folder structure and configurations for the project.


### `packages.yml`

This contains the packages that are used in the project. There is `package-lock.yml` that uses the software engineering practice of pinning requiring dependencies with their appropriate versions. (Like `go.mod` in golang `package-lock.json` in nodejs).



### `models/`

This contains the models that are used in the project.

- `schema.yml` - This contains the schema for the models.

- `*.sql` - This contains the models that are used in the project. Uses jinja template to have placeholders

### `macros/`

This contains the macros that are used in the project.

### `tests/`

This contains the tests that are used in the project. Follow TDD for data and enable writing test.

### `seeds/`

This contains the seeds that are used in the project. Useful for creating initial data into tables.

### `snapshots/`

This contains the snapshots that are used in the project. Useful for tracking changes in data over time.

### `analyses/`

This contains the analyses that are used in the project.

## Running the project

### `dbt run`

This runs the models in the project.

### `dbt test`

This runs the tests in the project.

### `dbt seed`

This runs the seeds in the project.

### `dbt snapshot`

This runs the snapshots in the project.

### `dbt docs generate`

This generates the documentation for the project.

### `dbt docs serve`

This serves the documentation for the project.

### `dbt source freshness`

This runs the source freshness for the project.

### `dbt build`

This runs the build for the project.

### `dbt clean`

This runs the clean for the project