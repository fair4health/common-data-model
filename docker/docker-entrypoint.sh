#!/bin/bash

JAVA_CMD="java -Xms256m -Xmx3g -jar -Dconfig.file=fair4health.conf -Dlogback.configurationFile=logback.xml onfhir-server-standalone.jar"

# Delay the execution for this amount of seconds
if [ ! -z "$DELAY_EXECUTION" ]; then
    sleep $DELAY_EXECUTION
fi

eval $JAVA_CMD
