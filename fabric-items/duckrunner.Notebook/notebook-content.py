# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "jupyter",
# META     "jupyter_kernel_name": "python3.12"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "7deef8f3-9263-4802-8fbe-eb72eade9ba1",
# META       "default_lakehouse_name": "storage",
# META       "default_lakehouse_workspace_id": "765a5a2b-3596-4e83-a39d-f2b211a8547c",
# META       "known_lakehouses": [
# META         {
# META           "id": "7deef8f3-9263-4802-8fbe-eb72eade9ba1"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

!pip install -q duckrun --upgrade
notebookutils.session.restartPython()

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "jupyter_python"
# META }

# CELL ********************

import os
from dbt.cli.main import dbtRunner, dbtRunnerResult

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "jupyter_python"
# META }

# CELL ********************

workspace = "765a5a2b-3596-4e83-a39d-f2b211a8547c"
lh_art_id = "7deef8f3-9263-4802-8fbe-eb72eade9ba1"
os.environ["TARGET_LH_PATH"] = f"abfss://{workspace}@onelake.dfs.fabric.microsoft.com/{lh_art_id}"
dbt_project_dir = "/lakehouse/default/Files/dbt"

dbt = dbtRunner()

cli_args = [
    "build",
    "--project-dir", dbt_project_dir,
    "--profiles-dir", dbt_project_dir
]

res: dbtRunnerResult = dbt.invoke(cli_args)

for r in res.result:
    print(f"{r.node.name}: {r.status}")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "jupyter_python"
# META }

# CELL ********************

# raise exceptions on failure
if res.exception:
    print(f"❌ dbt encountered a system exception: {result.exception}")
    raise result.exception

if not res.success:
    print("❌ dbt build or data tests failed!")
    
    for r in res.result:
        if r.status in ["fail", "error"]:
            print(f"  - Failure in: {r.node.name} (Status: {r.status})")
            
    raise RuntimeError(
        "dbt build failed due to test failures or model errors. See logs above."
    )

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "jupyter_python"
# META }

# CELL ********************

# generate docs in lakehouse
doc_args = [
    "docs", "generate",
    "--static",
    "--project-dir", dbt_project_dir,
    "--profiles-dir", dbt_project_dir
]

doc_res: dbtRunnerResult = dbt.invoke(doc_args)

if not doc_res.success:
    raise doc_res.exception

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "jupyter_python"
# META }
