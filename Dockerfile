FROM alpine:latest

LABEL "com.github.actions.name"="Staging regulation"
LABEL "com.github.actions.description"="Create a pull request to the staging branch after a hotfix"
LABEL "com.github.actions.icon"="corner-up-left"
LABEL "com.github.actions.color"="green"

LABEL "repository"="http://github.com/loyalguru/actions/staging_regulation"
LABEL "homepage"="http://github.com/loyalguru/staging_regulation"
LABEL "maintainer"="Eric Ponce <tricokun@gmail.com>"

RUN	apk add --no-cache \
	bash \
	ca-certificates \
	curl \
	jq

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
