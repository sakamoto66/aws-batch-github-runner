# AWS Batch for self hosted GitHub action runners

Launch a self-hosted runner with the flag "--ephemeral" via AWS Batch.  
It will be automatically terminated under any of the following conditions of the instance.

- The processing of the first job is finished
- I did not receive a job for a certain period of time after starting (default:120sec)

# Setup

## Step1. fork repository

- this repository fork

## Step2. Create Github Personal access token

- Note: `github self hosted runner`
- Expiration: `<Any>`
- Select scopes: `repo`

## Step3. Regist Github Personal access token in AWS Secrets Manager

- run terraform

```bash
$ cd regist-secret-key
$ terraform init
$ terraform plan
$ terraform apply
var.github_personal_access_token
  Enter a value: `<Github Personal access token>`
$ cd ..
```

## Step4. Setup AWS Batch

- run terraform

```bash
./generate-region.sh
$ cd terraform
$ terraform init
$ terraform plan
$ terraform apply
var.github_account
  Inputs github user or organization or '*'.

  Enter a value: 
var.github_repository
  Inputs repository or '*'.

  Enter a value: 
$ cd ..
```

- memo Value of `AWS_ROLE_ARN`.

## Step6. Regist Secret in GitHub repository

- Key
  - AWS_ROLE_ARN
- Value
  - `<memo of Step4>`

## Step7. test

- run .github/workflows/hello.yml on forked repository
