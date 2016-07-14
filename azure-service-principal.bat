echo "Creating Azure Service Principal"

docker-machine ls
docker-machine start default

@echo off

echo @echo off >> dm_config.bat
docker-machine env --shell cmd default | findstr /v # >> dm_config.bat
echo exit /B >> dm_config.bat
call dm_config.bat

del dm_config.bat

docker run -it microsoft/azure-cli azure login --environment AzureCloud
docker ps -l -q > cid.txt
set /p AZURECLI_CID= < cid.txt
del cid.txt
echo AzureCli CID: %AZURECLI_CID%

docker start %AZURECLI_CID%

docker exec %AZURECLI_CID% azure account list --json
docker exec %AZURECLI_CID% azure account list --json > account.json

setlocal EnableDelayedExpansion
for /f "tokens=1,2 delims=:, " %%a in (' find ":" ^< "account.json" ') do (
  set "%%~a=%%~b"
)
del account.json
set SUBSCRIPTION-ID=%id%
set TENANT_ID=%tenantID%
echo SUBSCRIPTION-ID: %SUBSCRIPTION-ID%
echo TENANT_ID: %TENANT_ID%

docker exec %AZURECLI_CID% azure account set %SUBSCRIPTION-ID%
docker exec %AZURECLI_CID% azure ad app create --name "My Service Principal for BOSH" --password "password" --home-page "http://MyBOSHAzureCPI" --identifier-uris "http://MyBOSHAzureCPI" --json > ad_app.json
docker exec %AZURECLI_CID% azure ad app list
for /f "tokens=1,2 delims=:, " %%a in (' find ":" ^< "ad_app.json" ') do (
  set "%%~a=%%~b"
)
del ad_app.json
set CLIENT_ID=%appId%
echo CLIENT_ID: %CLIENT_ID%

docker exec %AZURECLI_CID% azure ad sp create %CLIENT_ID% 

docker exec %AZURECLI_CID% azure role assignment create --spn %CLIENT_ID% --roleName "Virtual Machine Contributor" --subscription %SUBSCRIPTION-ID%
docker exec %AZURECLI_CID% azure role assignment create --spn %CLIENT_ID% --roleName "Network Contributor" --subscription %SUBSCRIPTION-ID%
docker exec %AZURECLI_CID% azure role assignment list --spn %CLIENT_ID%

docker exec %AZURECLI_CID% azure login --username %CLIENT_ID% --password "password" --service-principal --tenant %TENANT_ID% --environment AzureCloud

docker stop %AZURECLI_CID%
