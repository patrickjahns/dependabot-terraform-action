#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
CONTAINER_IMAGE=${IMAGE:-"patrickjahns/dependabot-terraform-action"}
CONTAINER_SHA=${1:-"latest"}
RESULT=0

# Colors
end="\033[0m"
green="\033[0;32m"
redb="\033[30;41m"


print_default() {
  echo -e "${end}${1}"
}

print_success() {
  echo -e "${green}${1}${end}"
}

print_error() {
  echo -e "${redb}${1}${end}"
}

print_start() {
  print_default "SCENARIO: "
  print_default "${1}"
  print_default "----------------------------------------------------------"
}

print_end() {
  print_default "----------------------------------------------------------"
}
print_nl() {
  echo ""
}

test_container_runs_successfully_on_local_repository() {
    print_start "Testing the container runs successfully"
    docker run -e INPUT_TARGET_BRANCH="GITHUB_TOKEN" \
               -e INPUT_GITHUB_DEPENDENCY_TOKEN="${DEPENDENCY_GITHUB_TOKEN}" \
               -e INPUT_TOKEN="${GITHUB_TOKEN}" \
               -e GITHUB_REPOSITORY="patrickjahns/dependabot-terraform-action"
               -e INPUT_DIRECTORY="/test/terraform"
               --rm ${CONTAINER_IMAGE}:${CONTAINER_SHA}
    retVal=$?
    print_end
    if [[ ${retVal} -ne 1 ]]; then
      print_error "FAILURE"
      RESULT=1
    else
      print_success "SUCCESS"
    fi
    print_nl
}

main() {
    print_default "Starting test suite .."
    pushd $SCRIPT_DIR > /dev/null
        test_container_runs_successfully_on_local_repository
    popd > /dev/null
    if [[ ${RESULT} -ne 0 ]]; then
      print_error "FAILURE"
    else
      print_success "SUCCESS"
    fi
    exit ${RESULT}
}

main