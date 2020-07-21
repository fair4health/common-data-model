FROM srdc/java:oraclejdk-8

# Create folders
RUN mkdir -p /fhir
RUN mkdir -p /fhir/conf

# Add Files
ADD onfhir-standalone.jar /fhir
ADD docker-entrypoint.sh /fhir

RUN chown root:root /fhir/docker-entrypoint.sh
RUN chmod +x /fhir/docker-entrypoint.sh


EXPOSE 8080
ENTRYPOINT ["/fhir/docker-entrypoint.sh"]
