#!/usr/bin/env bash

export INTERACTIVE=false

##
## HARVEST_LOGS from all BM machines
##
#rake scripts:run CMD=5,2,5 INTERACTIVE=true
#rake scripts:run CMD=5,3,5
#rake scripts:run CMD=5,4,5
#rake scripts:run CMD=5,5,5


##
## CLEAN UP LOGS from all BM machines
##
rake scripts:run CMD=1,2,5 INTERACTIVE=true
rake scripts:run CMD=1,3,5
rake scripts:run CMD=1,4,5
rake scripts:run CMD=1,5,5

##
## STOP BM NODE tomcat & postgres on BM machines
##
#rake scripts:run CMD=7,2,5 INTERACTIVE=true
#rake scripts:run CMD=7,3,5
#rake scripts:run CMD=7,4,5
#rake scripts:run CMD=7,5,5
#rake scripts:run CMD=7,7,0 #used also to kill tomcat for solr
