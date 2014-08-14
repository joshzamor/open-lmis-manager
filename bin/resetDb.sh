#!/bin/bash

export PGPASSWORD = 'p@ssw0rd'

./bin/shutdown.sh
dropdb -U postgres -h localhost open_lmis
createdb -U postgres -h localhost open_lmis \
    --encoding="UTF-8" \
    --template="template0" \ 
    --lc-collate="en_US.UTF-8" \ 
    --lc-ctype="en_US.UTF-8"
pg_restore open_lmis.custom | psql -q -U postgres -h localhost open_lmis -f -
./bin/startup.sh
