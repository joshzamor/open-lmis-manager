#!/bin/bash

export PGPASSWORD='p@ssw0rd'

curl --user managescript:tomcat "http://localhost:8080/manager/text/stop?path=/"
dropdb -U postgres -h localhost open_lmis
createdb -U postgres -h localhost open_lmis \
    --encoding="UTF-8" \
    --template="template0" \ 
    --lc-collate="en_US.UTF-8" \ 
    --lc-ctype="en_US.UTF-8"
pg_restore open_lmis.custom | psql -q -U postgres -h localhost open_lmis -f -
curl --user managescript:tomcat "http://localhost:8080/manager/text/start?path=/"
