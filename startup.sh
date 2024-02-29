#!/bin/bash

sudo mkdir /opt/webapp/
cd /opt/webapp/

DB_HOST=$(curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/attributes/db-host)
DB_USER=$(curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/attributes/db-user)
DB_PASS=$(curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/attributes/db-pass)
DB_NAME=$(curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/attributes/db-name)

cat <<EOF > ./.env
PSQL_DB=${DB_NAME}
PSQL_DB_USER=${DB_USER}
PSQL_DB_PASS=${DB_PASS}
PSQL_DB_HOST=${DB_HOST}
EOF

cat ./.env

touch /tmp/startup.sh.done