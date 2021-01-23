FROM openjdk:8-jre-slim

ENV ONFHIR_HOME /usr/local/onfhir
RUN mkdir -p "$ONFHIR_HOME"

WORKDIR $ONFHIR_HOME

COPY onfhir.io/onfhir-server-standalone.jar .
COPY onfhir.io/fair4health.conf .
COPY onfhir.io/logback.xml .
COPY onfhir.io/conf ./conf

COPY docker/docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]
