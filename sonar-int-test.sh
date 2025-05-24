#!/bin/bash

# Usage:
# ./runner.sh ls
# ./runner.sh update

# Define a list of known commands with associated execution logic
run_command() {
    case "$1" in
        package)
            CMD="jfrog-cli-sonar evd create --predicate-type https://jfrog.com/evidence/sonarqube/v1 --key /Users/bhanur/codebase/scripts/private.pem --package-name demo-sonar --package-version 1.0 --package-repo-name dev-maven-local --key-alias evidence-local"
            ;;
        build-info)
            CMD="jfrog-cli-sonar evd create --predicate-type https://jfrog.com/evidence/sonarqube/v1 --key /Users/bhanur/codebase/scripts/private.pem --build-name test-npm --build-number 111 --key-alias evidence-local"
            ;;
        repo-path)
            CMD="jfrog-cli-sonar evd create --predicate-type https://jfrog.com/evidence/sonarqube/v1 --key /Users/bhanur/codebase/scripts/private.pem --subject-repo-path dev-local/jf-rm --key-alias evidence-local"
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