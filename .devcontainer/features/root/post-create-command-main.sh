#!/bin/bash
source /workspace/user.env

echo "sh $0"
FEATURE_DIR=$(dirname $0)

# Gitの設定
# push.defaultとsafe.directory、pullは.envなくても設定しておく
git config --global push.default current
git config --global --add safe.directory /workspace
git config --global pull.ff only
git config --global commit.template .gitmessage
if [ "${GIT_USER_EMAIL}" != '' ] && [ "${GIT_USER_NAME}" != '' ]; then
  echo "Setting up a git config(user) ..."
  git config --global user.email "${GIT_USER_EMAIL}"
  git config --global user.name "${GIT_USER_NAME}"
  echo "Finished setting up git config"
fi

# GitHubの設定
if [ "${GITHUB_REMOTE_ORIGIN_URL}" != '' ]; then
  echo "Setting up a git config(remote.origin.url) ..."
  git config --global remote.origin.url $GITHUB_REMOTE_ORIGIN_URL
  echo "Finished setting up git config"
fi

# Git hookの設定
git config --local core.hooksPath .githooks
chmod -R +x .githooks/