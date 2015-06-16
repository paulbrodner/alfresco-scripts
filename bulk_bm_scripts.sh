#!/usr/bin/env bash

export INTERACTIVE=false

##
## HARVEST_LOGS from all BM machines
##
#rake scripts:run CMD=6,2,5 INTERACTIVE=true
rake scripts:run CMD=6,3,1 INTERACTIVE=true
rake scripts:run CMD=6,4,1
rake scripts:run CMD=6,5,1


##
## CLEAN UP LOGS from all BM machines
##
#rake scripts:run CMD=1,2,5 INTERACTIVE=true
#rake scripts:run CMD=1,3,5
#rake scripts:run CMD=1,4,5
#rake scripts:run CMD=1,5,5

##
## STOP BM NODE tomcat & postgres on BM machines
##
#rake scripts:run CMD=7,2,5 INTERACTIVE=true
#rake scripts:run CMD=7,3,5
#rake scripts:run CMD=7,4,5
#rake scripts:run CMD=7,5,5
#rake scripts:run CMD=7,7,0 #used also to kill tomcat for solr


##
## INSTALL ALFRESCO out of the box
##
#rake scripts:run CMD=8,2,6 INTERACTIVE=true
#rake scripts:run CMD=9,2,6
