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

!mkdir /lakehouse/default/Files/nyc-open-data
!curl -sSL -o /lakehouse/default/Files/nyc-open-data/collisions.csv https://data.cityofnewyork.us/api/views/h9gi-nx95/rows.csv?accessType=DOWNLOAD

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "jupyter_python"
# META }
