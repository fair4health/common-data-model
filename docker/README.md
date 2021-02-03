# onFHIR.io Repository with the FAIR4Health Common Data Model

The Common Data Model of the FAIR4Health Project is implemented by utilizing [HL7 FHIR profiles](https://www.hl7.org/fhir/profiling.html).

[onFHIR.oi](https://onfhir.io) is a high-performance and fully compliant HL7 [FHIR](https://www.hl7.org/fhir/) Repository. This image makes use of the [open source version of the onFHIR Repository](https://github.com/srdc/onfhir).

This image includes an onFHIR.io instance preconfigured with the FAIR4Health Common Data Model profiles.

<p align="center">
  <a href="https://www.fair4health.eu" target="_blank"><img width="400" src="https://www.fair4health.eu/images/logo.png" alt="FAIR4Health logo"></a>
</p>

<p align="center">
  <a href="https://github.com/fair4health/ppddm"><img src="https://img.shields.io/github/license/fair4health/common-data-model" alt="License"></a>
</p>

## How to use this image

Latest release can be quickly installed with the following `docker run` command. Please note that onFHIR.io uses MongoDB as its backend data storage system. onFHIR.io can be started with an embedded MongoDB instance while it can also connect to an existing running MongoDB instance through appropriate configuration parameters (see the Environment Variables).

    $ docker run --name f4h-onfhir -e APP_CONF_FILE=fair4health.conf -e LOGBACK_CONF_FILE=logback.xml -e DB_EMBEDDED=true -d fair4health/onfhir:latest

This image can also be run with `docker-compose`. The following example runs a mongo container and onFHIR is set to not to use an embedded MongoDB instance.

	version: '2'
	services:
	  mongo:
	    image: mongo:4.4
	    volumes:
	      - './volumes/mongo:/data/db'
	    ports:
	      - 27017:27017
	    container_name: f4h-mongo
	  onfhir:
	    image: fair4health/onfhir:latest
	    depends_on:
	      - mongo
	    environment:
	      APP_CONF_FILE: 'fair4health.conf'
	      LOGBACK_CONF_FILE: 'logback.xml'
	      FHIR_ROOT_URL: 'https://f4h.srdc.com.tr/fhir'
	      DB_EMBEDDED: 'false'
	      DB_HOST: 'f4h-mongo:27017'
	    ports:
	      - 8080:8080
	    container_name: f4h-onfhir

## Environment Variables

The onFHIR image of the FAIR4Health uses several environment variables.

**APP_CONF_FILE**: This environment variable can be used to provide all configuration parameters through a [Typesafe config file](https://github.com/lightbend/config). onFHIR Repository provides an [example of such a configuration file](https://github.com/srdc/onfhir/blob/master/onfhir-core/src/main/resources/application.conf) together with descriptions of the configuration parameters. This image ships with a predefined configuration file regarding the FAIR4Health Common Data Model FHIR profiles which can be found [here](https://github.com/fair4health/common-data-model/blob/master/onfhir.io/fair4health.conf).

**LOGBACK_CONF_FILE**: This environment variable can be used to provide a logback configuration file. This image ships with a logback configuration file which can be found [here](https://github.com/fair4health/common-data-model/blob/master/onfhir.io/logback.xml).

**SERVER_HOST**: Hostname (or IP address) that the onFHIR server will bind. Using 0.0.0.0 will bind the server to both localhost and the IP of the server that you deploy it.

**SERVER_PORT**: Port number that the onFHIR server will listen.

**SERVER_BASE_URI**: Base URI for the onFHIR server e.g. With the default configuration, the root path of the FHIR server will be `http://localhost:8080/fhir` in which `/fhir` is the `SERVER_BASE_URI`.

**FHIR_INIT**: When true, then for every restart of the server, it reads the FHIR configuration files, configure the onFHIR instance accordingly and then setup/update the MongoDB database. This should be true if executed for the first time. When false, then for every restart of the server, it configures the onFHIR instandce by reading the existing configurations from the database, not from the configuration files.

**FHIR_ROOT_URL**: Root URL for Server Access (this can be different from the SERVER_HOST parameter due to deployment alternatives especially when you are deploying the server behind a proxy). The value of this variable should be the URL which can be used to access to the onFHIR server from outside world so that the Accessible links can be created accordingly.

**DB_EMBEDDED**: onFHIR server requires a MongoDB instance. The application can be run on an embedded MongoDB instance if no external MondoDB is configured through the `DB_HOST` variable. If `DB_EMBEDDED` is true, then the MongoDB instance will be automatically started on the first `host:port` parameter provided with the `DB_HOST` environment variable.

**DB_HOST**: Host and ports for the MongoDB databases (you can use multiple if it is a sharded cluster or replica set). While `"localhost:27017"` is a valid single instance configuration, you can give `"localhost:27019,localhost:27020"` to enable the onFHIR server work on multiple MongoDB instances.

**DB_NAME**: The name of the database to be created for running the onFHIR server.
