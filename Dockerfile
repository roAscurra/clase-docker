FROM alpine:latest as build

RUN apk update
RUN apk add openjdk17

COPY . .
RUN chmod +x ./gradlew
#para crea la carpeta build:
RUN ./gradlew bootJar --no-daemon

FROM openjdk:17-alpine
EXPOSE 9000
COPY --from=build ./build/libs/Practicas-0.0.1-SNAPSHOT.jar ./app.jar

ENTRYPOINT ["java", "-jar","app.jar"]