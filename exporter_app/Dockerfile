FROM jruby:9
COPY . /usr/src/exporter
WORKDIR /usr/src/exporter
RUN bin/bootstrap.sh
ENTRYPOINT bin/startup.sh
