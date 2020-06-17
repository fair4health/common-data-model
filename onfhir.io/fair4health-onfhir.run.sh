#!/bin/sh

docker run --name fair4health-onfhir -d \
        -v /docker-containers/fair4health/fhir/conf:/fhir/conf \
        --net="host" \
		-e APP_CONF_FILE=/fhir/conf/application-docker.conf \
		-e LOGBACK_CONF_FILE=/fhir/conf/logback.xml \
		-e LOG_LEVEL=INFO \
        --restart=always srdc/onfhir:fhir-repository

