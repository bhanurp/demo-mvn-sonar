# demo-mvn-sonar
sample project which uses sonar maven plugin.
Below are the workflows on how to use on different use cases

## Create signing key pair

```shell
openssl genrsa -out private.pem 2048
openssl rsa -in private.pem -pubout -out public.pem
```

## Attach evidence on multiple subjects
Use `./sonar-int-test.sh` to create and attach evidence on artifact, pacakge, build-info
by passing arguments. Update variables in the script as per your choice and run below

```shell
./sonar-int-test.sh build-info
```

```shell
./sonar-int-test.sh package
```

```shell
./sonar-int-test.sh repo-path
```

## Example Workflow 1
1. Set your SonarQube token:
```shell
export SONAR_TOKEN=your-token-here
```

2. Run SonarQube analysis (Maven example):

```shell
mvn clean verify sonar:sonar \
-Dsonar.projectKey=mvn-sonar \
-Dsonar.projectName=mvn-sonar \
-Dsonar.host.url=http://localhost:9999 \
-Dsonar.token=<TOKEN>
```

3. Create and sign evidence:

```shell
jf evd create --predicate-type="https://jfrog.com/evidence/sonarqube/v1" --key="/Users/bhanur/codebase/scripts/private.pem" --package-name="demo-sonar" --package-version="1.0" --package-repo-name="dev-maven-local" --key-alias="evidence-local"
```
use ./sonar-int-test.sh file script to attach evidence on different subjects like build-info, packages, subjec-repo-path

## Example Workflow 2
1. Set your SonarQube token:
```shell
export SONAR_TOKEN=your-token-here
```

2. Use sonar-cli to run the scan

```shell
sonar-scanner \
  -Dsonar.projectKey=SUP_workers_sonarqube_evidence_poc_5ddce6d3-4562-4ad0-8dbb-e10a2ae31c64 \
  -Dsonar.projectName='workers_sonarqube_evidence_poc' \
  -Dsonar.host.url=https://sonar.jfrog.info \
  -Dsonar.token=sqa_d2acb7ba6a3836f8f0a1b5384972228f4b86206c \
  -Dsonar.java.binaries=target/classes
```

3. Create and sign evidence

```shell
jf evd create --predicate-type="https://jfrog.com/evidence/sonarqube/v1" --key="/Users/bhanur/codebase/scripts/private.pem" --package-name="demo-sonar" --package-version="1.0" --package-repo-name="dev-maven-local" --key-alias="evidence-local"
```
use ./sonar-int-test.sh file script to attach evidence on different subjects like build-info, packages, subjec-repo-path

## Example Workflow 3
Use evidence.yaml incase the required configuration is not matching
change URL, report-task.txt file path or number of retries and time interval

1. Create new evidence.yaml by using below command and answer interactive questions by the user.

```shell
jf evd gc sonar
```

2. Set your SonarQube token:
```shell
export SONAR_TOKEN=your-token-here
```

3. Use one of the client either sonar plugin for maven package manager or sonar cli and trigger sonar scan
4. Create and sign evidence

```shell
jf evd create --predicate-type="https://jfrog.com/evidence/sonarqube/v1" --key="/Users/bhanur/codebase/scripts/private.pem" --package-name="demo-sonar" --package-version="1.0" --package-repo-name="dev-maven-local" --key-alias="evidence-local"
```