FROM node:10-alpine
LABEL maintainer "Lework <lework@yeah.net>"

ENV TIMEZONE=Asia/Shanghai

ADD entrypoint.sh .releaserc /semantic-release/

RUN apk --no-cache add tzdata git \
    && ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    && npm i -g semantic-release \
       @semantic-release/changelog \
       @semantic-release/exec \
       @semantic-release/git \
    && chmod +x /semantic-release/entrypoint.sh


ENTRYPOINT ["/semantic-release/entrypoint.sh"]

CMD semantic-release $SEMANTIC_OPTIONS
