#!/usr/bin/env bash

script_dir=$(cd "$(dirname "$0")" ; pwd -P)

fetch-repo-name() {
  echo "$([[ $(git ls-remote --get-url origin) =~ github.com.*[\/|\:](.*[\/|\:].*).git ]] && echo "${BASH_REMATCH[1]}")"
}

fetch-github-registration-token() {
  github_username="${1}"

  if [ -z "${github_username}" ]; then
    echo "GITHUB_USERNAME not set. Usage <func> GITHUB_USERNAME"
    exit 1
  fi

  repo_name=get_repo_name
  response=$(curl \
    -u $github_username \
    -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/${repo_name}/actions/runners/registration-token)

  echo $response | jq -r .token
}

