#!/bin/bash

[ -z "$JAVA_XMS" ] && JAVA_XMS=2048m
[ -z "$JAVA_XMX" ] && JAVA_XMX=2048m

set -e

# OpenTelemetry:
# https://github.com/open-telemetry/opentelemetry-java-instrumentation
JAVA_OPTS="${JAVA_OPTS} \
  -Xms${JAVA_XMS} \
  -Xmx${JAVA_XMX} \
  -Dapplication.name=${APP_NAME} \
  -Dapplication.home=${APP_HOME} \
  -Dotel.exporter=jaeger \
  -Dotel.jaeger.endpoint=jaeger:14250 \
  -Dotel.jaeger.service.name=otel-provider2 \
  -javaagent:${APP_HOME}/opentelemetry-javaagent-all.jar"

JAVA_OPTS2="${JAVA_OPTS} \
  -Xms${JAVA_XMS} \
  -Xmx${JAVA_XMX} \
  -Dapplication.name=${APP_NAME} \
  -Dapplication.home=${APP_HOME} "

exec java ${JAVA_OPTS2} \
  -jar "${APP_HOME}/${APP_NAME}.jar" \
  --spring.config.location=/config/application.yml
