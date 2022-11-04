FROM openjdk:17-alpine3.14
WORKDIR /app
COPY target/ .
EXPOSE 8181
CMD ["java", "-jar", "covid-tracker-application-0.0.1-SNAPSHOT.jar", "--server.port=8181"]
