export DBT_LAKEHOUSE_URL="https://onelake.dfs.fabric.microsoft.com/$DUCKRUN_WORKSPACE_ID/$DUCKRUN_LH_ID/Files/dbt"

azcopy sync "./dbt" "$DBT_LAKEHOUSE_URL" \
    --recursive=true \
    --delete-destination=true \
    --trusted-microsoft-suffixes "fabric.microsoft.com"