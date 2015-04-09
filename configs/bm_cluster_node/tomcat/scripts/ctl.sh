#!/bin/sh

CATALINA_HOME=/home/bm0013/alfresco-4.1.10/tomcat
TOMCAT_BINDIR=/home/bm0013/alfresco-4.1.10/tomcat/bin
JAVA_HOME=/home/bm0013/alfresco-4.1.10/java
CATALINA_PID=/home/bm0013/alfresco-4.1.10/tomcat/temp/catalina.pid
export CATALINA_PID
TOMCAT_STATUS=""
ERROR=0
PID=""

start_tomcat() {
    is_tomcat_running
    RUNNING=$?
    if [ $RUNNING -eq 1 ]; then
        echo "$0 $ARG: tomcat (pid $PID) already running"
    else
	rm -f $CATALINA_PID
	export JAVA_OPTS="-XX:MaxPermSize=512m -Xms1G -Xmx20G -Xss1024k -XX:+DisableExplicitGC -Djava.awt.headless=true -Dalfresco.home=/home/bm0013/alfresco-4.1.10 -Dcom.sun.management.jmxremote -Dsun.security.ssl.allowUnsafeRenegotiation=true"
	$TOMCAT_BINDIR/startup.sh 
	if [ $? -eq 0 ];  then
            echo "$0 $ARG: tomcat started"
	else
            echo "$0 $ARG: tomcat could not be started"
            ERROR=1
	fi
    fi
}

daemon_tomcat() {
    export JAVA_OPTS="-XX:MaxPermSize=512m -Xms1G -Xmx20G -XX:+DisableExplicitGC -Djava.awt.headless=true -Dalfresco.home=/home/bm0013/alfresco-4.1.10 -Dcom.sun.management.jmxremote -Dsun.security.ssl.allowUnsafeRenegotiation=true -XX:ReservedCodeCacheSize=128m"
    $TOMCAT_BINDIR/catalina.sh run
}

stop_tomcat() {
    is_tomcat_running
    RUNNING=$?
    if [ $RUNNING -eq 0 ]; then
        echo "$0 $ARG: $TOMCAT_STATUS"
        exit
    fi
    $TOMCAT_BINDIR/shutdown.sh 300 -force 
    sleep 2
    is_tomcat_running
    RUNNING=$?
    COUNTER=4
    while [ $RUNNING -ne 0 ] && [ $COUNTER -ne 0 ]; do
        COUNTER=`expr $COUNTER - 1`
        sleep 2
        is_tomcat_running
        RUNNING=$?
    done
    if [ $RUNNING -eq 0 ]; then
        echo "$0 $ARG: tomcat stopped"
        sleep 3
    else
        echo "$0 $ARG: tomcat could not be stopped"
        ERROR=2
    fi
}

get_pid() {
    PID=""
    PIDFILE=$1
    # check for pidfile
    if [ -f $PIDFILE ] ; then
        PID=`cat $PIDFILE`
    fi
}

get_tomcat_pid() {
    get_pid $CATALINA_PID
    if [ ! $PID ]; then
        return
    fi
}

is_service_running() {
    PID=$1
    if [ "x$PID" != "x" ] && kill -0 $PID 2>/dev/null ; then
        RUNNING=1
    else
        RUNNING=0
    fi
    return $RUNNING
}

is_tomcat_running() {
    get_tomcat_pid
    is_service_running $PID
    RUNNING=$?
    if [ $RUNNING -eq 0 ]; then
        TOMCAT_STATUS="tomcat not running"
    else
        TOMCAT_STATUS="tomcat already running"
    fi
    return $RUNNING
}

cleanpid() {
    rm -f $CATALINA_PID
}

if [ "x$1" = "xstart" ]; then
    start_tomcat
    sleep 2
elif [ "x$1" = "xdaemon" ]; then
    daemon_tomcat
elif [ "x$1" = "xstop" ]; then
    stop_tomcat
    sleep 2
elif [ "x$1" = "xstatus" ]; then
    is_tomcat_running
    echo $TOMCAT_STATUS
elif [ "x$1" = "xcleanpid" ]; then
    cleanpid
fi

exit $ERROR
