FROM eclipse-temurin:21-jre-alpine

ARG BFG_VERSION=1.15.0

LABEL bfg.version=$BFG_VERSION
LABEL image.tag=$BFG_VERSION

RUN set -ex \
    && apk add --no-cache ca-certificates curl \
    && curl -fsSL -o /usr/bin/bfg.jar \
        "https://repo1.maven.org/maven2/com/madgag/bfg/${BFG_VERSION}/bfg-${BFG_VERSION}.jar" \
    && mkdir /data

WORKDIR /data

ENTRYPOINT ["java", "-jar", "/usr/bin/bfg.jar"]
