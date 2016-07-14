echo "Creating Azure Service Principal"

docker-machine ls
docker-machine start default

@echo off

echo @echo off >> dm_config.bat
docker-machine env --shell cmd default | findstr /v # >> dm_config.bat
echo exit /B >> dm_config.bat
call dm_config.bat

del dm_config.bat

REM docker run -it microsoft/azure-cli azure login --environment AzureCloud
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
docker exec %AZURECLI_CID% azure ad app create --name "My Service Principal for BOSH" --password "password" --home-page "http://MyBOSHAzureCPI" --identifier-uris "http://MyBOSHAzureCPI"
docker exec %AZURECLI_CID% azure ad app list

docker stop %AZURECLI_CID%
