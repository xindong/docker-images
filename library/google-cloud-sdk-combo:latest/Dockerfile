FROM xindong/google-cloud-sdk:latest

LABEL image.tag='latest'

RUN apk update -f && apk upgrade -f && \
    apk --no-cache add -f jq && \
    rm -rf /var/cache/apk/* && \
    # install all components
    components=`gcloud components list --format=json 2>/dev/null \
        | jq '[.[] | { id: .id , installed: .state.name } | select(.installed == "Not Installed") | .id ]' \
        | jq -r '. | join(" ")'` && \
    gcloud -q components install $components && \
    gcloud version

VOLUME ["/root/.config"]
