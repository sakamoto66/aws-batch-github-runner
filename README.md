# AWS Batch for self hosted GitHub action runners

Launch a self-hosted runner with the flag "--ephemeral" via AWS Batch.  
It will be automatically terminated under any of the following conditions of the instance.
- The processing of the first job is finished
- I did not receive a job for a certain period of time after starting (default:120sec)

## Setup
### Step1. Create Github Personal access token

- Note: `aws batch`
- Expiration: `<Any>`
- Select scopes: `admin:org`

### Step2. Create Github Organization

- Name: `<Any>`

### Step3. AWS Secret

- Open Secrets Manager
- Create New Secret
- Secret Type: Other
- Secret Name: `<Any>`
- Key&Value
  - ACCESS_TOKEN: `<Github Personal access token>`
  - ORG_NAME: `<Github Organization>`
- Save
- Memo Secret arn  
ex)
```
arn:aws:secretsmanager:<region>:<account id>:secret:<Secret Name>-XXXXXX
```

### Step4. setup aws batch

- run terraform
```
git clone https://github.com/sakamoto66/aws-batch-github-runner.git
cd aws-batch-github-runner
./generate-region.sh us-east-1
cd terraform
terraform init
terraform init -var 'arn:aws:secretsmanager:<region>:<account id>:secret:<Secret Name>-XXXXXX'
terraform apply -auto-approve -var 'arn:aws:secretsmanager:<region>:<account id>:secret:<Secret Name>-XXXXXX'
```
### Step5. test

```bash
aws --region us-east-1 batch submit-job \
--job-name test \
--job-queue self_hosted_runner_spot \
--job-definition self_hosted_runner \
--timeout attemptDurationSeconds=600 \
--container-overrides '{"vcpus": 8, "environment":[{"name":"LABELS","value":"loadtest"}]}'
```

### Step6. check runner

- show bashboard
  - https://us-east-1.console.aws.amazon.com/batch/home?region=us-east-1

- If RUNNING is count up. show github runners
https://github.com/organizations/<my organization>/settings/actions/runners


### Step7. run github action

- this repository fork
- run .github/workflows/hello.yml on github.com

