FROM maven AS BUILD_IMAGE
COPY ./orders-service orders-MS
RUN cd orders-MS && mvn install -B

FROM openjdk:8-jdk-alpine
LABEL "Project"="Orders-Service"
LABEL "Author"="Sergio"
WORKDIR /app
COPY --from=BUILD_IMAGE orders-MS/target/orders-service-example-0.0.1-SNAPSHOT.jar /app/orders-service.jar
EXPOSE 8080
CMD ["java","-jar", "/app/orders-service.jar",$APP_ARGS]