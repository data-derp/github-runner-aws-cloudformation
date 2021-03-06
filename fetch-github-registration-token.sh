#!/usr/bin/env bash

script_dir=$(cd "$(dirname "$0")" ; pwd -P)

fetch-repo-name() {
  pushd "$(pwd)" > /dev/null
    echo "$([[ $(git ls-remote --get-url origin) =~ github.com.*[\/|\:](.*[\/|\:].*).git ]] && echo "${BASH_REMATCH[1]}")"
  popd > /dev/null
}

fetch-github-registration-token() {
  github_username="${1}"
  github_repo_name="${2}"

  if [ -z "${github_username}" ]; then
    echo "GITHUB_USERNAME not set. Usage <func> GITHUB_USERNAME"
    exit 1
  fi

  response=$(curl \
    -u $github_username \
    -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/${github_repo_name}/actions/runners/registration-token)

  echo $response
}

