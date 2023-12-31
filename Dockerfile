FROM amazoncorretto:11-alpine AS builder
ENV USE_PROFILE local

COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
RUN chmod +x ./gradlew
RUN ./gradlew clean bootJar

FROM amazoncorretto:11-alpine
COPY --from=builder build/libs/*.jar app.jar

ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=${USE_PROFILE}", "/app.jar"]
