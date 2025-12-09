# Build stage
FROM maven:3.8-jdk-11 AS builder

WORKDIR /usr/src/geonetwork

# Copy the entire project
COPY . .

# Build the project and create the WAR file
# The command is taken from the release-build.sh script
RUN mvn clean install -DskipTests -ntp -Pwar -Pwro4j-prebuild-cache

# Runtime stage
FROM jetty:9-jre11

# The geonetwork.war file is in web/target/
COPY --from=builder /usr/src/geonetwork/web/target/geonetwork.war /var/lib/jetty/webapps/geonetwork.war

# Expose the default Jetty port
EXPOSE 8080
