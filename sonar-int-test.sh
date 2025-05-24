#!/bin/bash

# Usage:
# ./runner.sh ls
# ./runner.sh update

KEY="/Users/bhanur/codebase/scripts/private.pem"
KEY_ALIAS="evidence-local"
PACKAGE_NAME="demo-sonar"
PACKAGE_VERSION="1.0"
PACKAGE_REPO_NAME="dev-maven-local"
BUILD_NAME="test-npm"
BUILD_NUMBER="111"
SUBJECT_REPO_PATH="dev-local/jf-rm"

# Define a list of known commands with associated execution logic
run_command() {
    case "$1" in
        package)
            CMD="jfrog-cli-sonar evd create --predicate-type https://jfrog.com/evidence/sonarqube/v1 --key ${KEY} --package-name ${PACKAGE_NAME} --package-version ${PACKAGE_VERSION} --package-repo-name ${PACKAGE_REPO_NAME} --key-alias ${KEY_ALIAS}"
            ;;
        build-info)
            CMD="jfrog-cli-sonar evd create --predicate-type https://jfrog.com/evidence/sonarqube/v1 --key ${KEY} --build-name ${BUILD_NAME} --build-number ${BUILD_NUMBER} --key-alias ${KEY_ALIAS}"
            ;;
        repo-path)
            CMD="jfrog-cli-sonar evd create --predicate-type https://jfrog.com/evidence/sonarqube/v1 --key ${KEY} --subject-repo-path ${SUBJECT_REPO_PATH} --key-alias ${KEY_ALIAS}"
            ;;
        *)
            echo "Unknown command: $1"
            echo "Available commands: list, update, disk, hello"
            exit 1
            ;;
    esac

    # Echo and run the command
    echo "Executing: $CMD"
    eval "$CMD"
}

# Validate argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <command>"
    exit 1
fi

run_command "$1"