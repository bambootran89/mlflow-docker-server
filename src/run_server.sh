
run() {
  AUTH_URI=postgresql://${PSQL_DB_USERNAME}:${PSQL_DB_PASSWORD}@${PSQL_DB_HOST}:${PSQL_DB_PORT}/${PSQL_AUTH_DATABASE}
  STORE_URI=postgresql://${PSQL_DB_USERNAME}:${PSQL_DB_PASSWORD}@${PSQL_DB_HOST}:${PSQL_DB_PORT}/${PSQL_MLFLOW_DATABASE}
  echo "STORE_URI=$AUTH_URI"
  echo "STORE_URI=$STORE_URI"
  echo "MLFLOW_ARTIFACT_URI=$MLFLOW_ARTIFACT_URI"
  /bin/bash -c "sed -i 's|<DB_URI>|postgresql://${PSQL_DB_USERNAME}:${PSQL_DB_PASSWORD}@${PSQL_DB_HOST}:${PSQL_DB_PORT}/${PSQL_AUTH_DATABASE}|g' /home/mlflow/my_auth_config.ini"
  export MLFLOW_AUTH_CONFIG_PATH=/home/mlflow/my_auth_config.ini
  #  
  mlflow server --app-name basic-auth --host 0.0.0.0 --port 5000 --backend-store-uri $STORE_URI --default-artifact-root $MLFLOW_ARTIFACT_URI --gunicorn-opts "--timeout 180"
}

run $* 2>&1 | tee server.log
