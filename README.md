# drone-semantic-release

![docker hub](https://img.shields.io/docker/pulls/lework/drone-semantic-release.svg?style=flat-square)
![docker hub](https://img.shields.io/docker/stars/lework/drone-semantic-release.svg?style=flat-square)
[![Build Status](https://travis-ci.com/lework/Docker-drone-semantic-release.svg?branch=master)](https://travis-ci.com/lework/Docker-drone-semantic-release)
[![](https://images.microbadger.com/badges/image/lework/drone-semantic-release.svg)](http://microbadger.com/images/lework/drone-semantic-release "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/lework/drone-semantic-release.svg)](http://microbadger.com/images/lework/drone-semantic-release "Get your own version badge on microbadger.com")


Drone plugin for making semantic releases based on https://github.com/semantic-release/semantic-release.

## Usage

See [commit message format](https://github.com/semantic-release/semantic-release#commit-message-format) to use it.

Add the following to the drone configuration

```yml
kind: pipeline
name: default

steps:
- name: semantic-release
  image: lework/semantic-release
  settings:
    git_user_name: bot # semantic release committer name (git config user.name)
    git_user_email: bot@example.com # semantic release committer email (git config user.email)
    github_token: # semantic release token (for authentication)
      from_secret: token
```

or for BitBucket

```yml
    bitbucket_token: # semantic release token (for authentication)
      from_secret: token
```

or for GitLab

```yml
    gitlab_token: # semantic release token (for authentication)
      from_secret: token
```

or for any git server (including BitBucket cloud which does not support tokens):

```yml
    git_login: bot
    git_password:
      from_secret: password
```

docker run

```bash
git clone http://192.168.77.132/root/test.git
docker run --rm -e PLUGIN_GIT_USER_NAME=root -e PLUGIN_GIT_USER_EMAIL=root@test.com -e PLUGIN_GIT_LOGIN=root -e PLUGIN_GIT_PASSWORD=12345678 -v $(pwd)/test:/app -w /app lework/drone-semantic-release:latest
```

## What it does

Runs on master branch only. Skips any actions below while on other branches.

- automatically creates a semantic version number
- attaches the version number as repo's git tag
- If there is no .releaserc in the repository, the default file will be used. exposes the version number into the file `.release-version`
- automatically creates, populates and pushes CHANGELOG.md to your master branch

## License

MIT

Thanks [entwico](https://github.com/entwico/semantic-release-drone.git)
