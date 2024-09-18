#
# Build stage
#
FROM maven:3.8.7-eclipse-temurin-17-alpine AS build
COPY ./ /home/app
RUN mvn -f /home/app/pom.xml clean install

#
# Package stage
#
FROM tomcat:8.5-jdk11

ENV GN_FILE geonetwork.war
ENV DATA_DIR=$CATALINA_HOME/webapps/geonetwork/WEB-INF/data
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -server -Xms512m -Xmx2024m -XX:NewSize=512m -XX:MaxNewSize=1024m -XX:+UseConcMarkSweepGC"
ENV GN_DIR $CATALINA_HOME/webapps/geonetwork

#Environment variables
ENV GN_VERSION 4.4.5

WORKDIR $CATALINA_HOME/webapps

USER root

RUN apt-get -y update && \
    apt-get -y install --no-install-recommends \
        curl \
        unzip

COPY --from=build /home/app/web/target/geonetwork.war geonetwork.war

RUN mkdir -p geonetwork && \
     unzip -e $GN_FILE -d geonetwork && \
     rm $GN_FILE

# To enable AJP and support for traefik headers
COPY ./georoma/server.xml $CATALINA_HOME/conf/server.xml

#Set geonetwork data dir
COPY ./georoma/docker-entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 8009

ENTRYPOINT ["/entrypoint.sh"]

CMD ["catalina.sh", "run"]
