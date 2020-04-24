FROM openjdk:8-jre-alpine

WORKDIR /flyway

RUN apk --no-cache add --update bash openssl curl

# Add the flyway user and step in the directory
RUN adduser -S -h /flyway -D flyway

COPY --chown=flyway:flyway ./scripts/wait-for-it.sh /usr/bin/wait-for-it

# Change to the flyway user
USER flyway

ENV FLYWAY_VERSION 6.4.0

RUN wget https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && mv flyway-${FLYWAY_VERSION}/* . \
  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz

ENTRYPOINT ["/flyway/flyway"]
CMD ["-?"]