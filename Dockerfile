# Стадия 1: Сборка WAR
FROM maven:3.8-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Стадия 2: Запуск с Tomcat
FROM tomcat:9.0-jre17
COPY --from=builder /app/target/team_project-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Удаляем дефолтный ROOT
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Порт
EXPOSE 8080

# Запуск
CMD ["catalina.sh", "run"]