# NetSuite Query Studio for VS Code

## About

NetSuite Query Studio is a light weight wrapper for making JDBC connections via SuiteAnalytics Connect (NetSuite2). It's designed to be used in VS Code with Jupyter notebooks and make developing DB queries easier. It can run queries, display outputs, and includes a DB Object Explorer called `schema_viewer`. Polars is used to display outputs and can be used to extend notebook functionality.

## Set Up

### Requirements

1. Download Python 3.7 - 3.10, the latest version will not work. Then run the following command.
2. Download Java 9 - 11.
3. Clone this repository.
4. `pip install -r requirements.txt`
5. Install the Juypter notebook extension to VSCode.
6. Download the `.jar` file for your OS. Place it at the root folder of this repository.
   - [Windows](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_3996479815.html#Installing-the-JDBC-Driver-for-Windows)
   - [Linux](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_4044023088.html#Installing-the-JDBC-Driver-for-Linux)
   - [OS X](https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_4520819104.html#Installing-the-JDBC-Driver-for-OS-X)

### .env
Create a `.env` file at the root folder of this repository with the following contents. Supply your own access token variables.

```bash
#the SQL file to run, 'schema' if you want to pull the db schema for a table.
EXECUTE=query
#the table you want to pull and/or view the schema of. Leave blank to view all tables.
DESCRIBE=
#the maximum width used to display database fields
MAXCOLWIDTH=40

#access token variables
USER=TBA
ACCOUNTID=1234567
ROLEID=...
CONSUMERKEY=...
CONSUMERSECRET=...
TOKENID=...
TOKENSECRET=...
```

* The `EXECUTE` variable determines which sql file will run. These can be found in the queries folder. 
    > The value `schema` will run the premade `schema.sql` file, which will save the schema files of the table in `DESCRIBE` to your local machine.
* The `DESCRIBE` variable determines what table will be described by the `schema_viewer.ipynb`. Execute `schema` if the neccesary schema files are missing.
* The `MAXCOLWIDTH` variable defines the max width used to display strings in polars.

### Test Connection by Initializing the Schema Files
Navigate to the schema folder. You can test your setup is correct from there.

1. Hit `Run All` in the `init.ipynb` notebook.   

It worked if the `object_explorer.parquet` file is created. If `.env.DESCRIBE` is blank, you should now be able to hit run in the `schema_viewer.ipynb` notebook and the DB tables will display.


## How to Run a Query
1. Add your query to the queries folder in a `.sql` file.
2. Change the `EXECUTE` variable in your `.env` file to the whatever you named your `.sql` file.
3. Open `execute.ipynb`
4. Hit `Run All`

<img src="/imgs/execute.gif" alt="execute gif" width="928">

## How to Use the Schema Viewer
A schema file must be downloaded for every table before that table can be viewed.

<img src="/imgs/schema_viewer.gif" alt="schema viewer gif" width="928">

### 1. Downloading Schema Files
1. Open your `.env` file.
2. Change the `EXECUTE` variable to `schema`.
3. Change the `DESCRIBE` variable to the table whose schema you want to download.
4. Open `execute.ipynb`
5. Hit `Run All`

### 2. Viewing Schema Files
1. Open your `.env` file.
2. Change the `DESCRIBE` variable to the table whose schema you want to view. Leave blank to see all tables.
3. Open `./schema/schema_viewer.ipynb`
4. Hit `Run All`

#### Viewer Options
* You can enter a regex search pattern in the `pattern` variable to find columns more easily.
* To see dataype or table definitions, copy paste columns/tables from the schema viewer output to the `drilldown` variable. Then rerun the viewer.
* Hit <code><i>open in a <u>text editor</u></code></i> to see the full output.

```python
# regex search pattern, matching columns will be sorted to the top
pattern = "cust"

# copy paste the columns you want to drill into below
drilldown = """
  └─🗝️ category: customerCategory.id
  └─ comments
  └─ companyname
"""
```

<img src="/imgs/schema_viewer_options.gif" alt="schema viewer options gif" width="928">

## Jupter Notebook UX Tip
Hit the gray or blue bar on the left of a code cell to minimize that cell. This frees up screen restate for viewing query outputs.

<img src="/imgs/collapse.gif" alt="collapse gif" width="928">
