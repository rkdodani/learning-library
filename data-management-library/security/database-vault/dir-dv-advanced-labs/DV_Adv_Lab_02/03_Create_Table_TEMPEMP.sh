#!/bin/bash

# keep track of script usage with a simple curl query
# the remote host runs nginx and uses a javascript function to mask your public ip address
# see here for details: https://www.nginx.com/blog/data-masking-user-privacy-nginscript/
#
file_path=`realpath "$0"`
curl -Is --connect-timeout 3 http://150.136.21.99:6868${file_path} > /dev/null

. $DBSEC_ADMIN/cdb.env

$ORACLE_HOME/bin/sqlplus -s dba_harvey/Oracle123@pdb1 << EOF

spool 03_Create_Table_TEMPEMP.out

drop table employeesearch_prod.temp_emp;
create table employeesearch_prod.temp_emp as select * from employeesearch_prod.demo_hr_employees;

exit;

EOF
