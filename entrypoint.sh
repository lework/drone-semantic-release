#!/bin/sh

set -e

export GIT_AUTHOR_NAME=${PLUGIN_GIT_USER_NAME:-}
export GIT_AUTHOR_EMAIL=${PLUGIN_GIT_USER_EMAIL:-}
export GIT_COMMITTER_NAME=${PLUGIN_GIT_USER_NAME:-}
export GIT_COMMITTER_EMAIL=${PLUGIN_GIT_USER_EMAIL:-}

export GH_TOKEN=${PLUGIN_GITHUB_TOKEN:-}
export GL_TOKEN=${PLUGIN_GITLAB_TOKEN:-}
export BB_TOKEN=${PLUGIN_BITBUCKET_TOKEN:-}

export GIT_CREDENTIALS=$(node --eval="const{PLUGIN_GIT_LOGIN,PLUGIN_GIT_PASSWORD}=process.env;if(PLUGIN_GIT_LOGIN && PLUGIN_GIT_PASSWORD){console.log
(encodeURIComponent(PLUGIN_GIT_LOGIN)+':'+encodeURIComponent(PLUGIN_GIT_PASSWORD))}")

[ ! -f .releaserc ] && mv /semantic-release/.releaserc .releaserc

if [ ! -z ${GIT_CREDENTIALS:-} ]; then
  export SEMANTIC_OPTIONS="--no-ci"
  sed -i "s#//#//$GIT_CREDENTIALS@#g" .git/config
fi

exec "$@"
