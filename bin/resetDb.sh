#!/bin/bash

export PGPASSWORD='p@ssw0rd'
export TOMCAT_PASS=@@@TOMCAT_PASS@@@

curl --user managescript:$TOMCAT_PASS "http://localhost:8080/manager/text/stop?path=/"
dropdb -U postgres -h localhost open_lmis
createdb -U postgres -h localhost open_lmis
pg_restore open_lmis.custom | psql -q -U postgres -h localhost open_lmis -f -
curl --user managescript:$TOMCAT_PASS "http://localhost:8080/manager/text/start?path=/"
curl -L "http://localhost:8080"
