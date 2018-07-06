# ECS Deployer using Terraform

This is a sample of how to use terraform to deploy to ECS. The cluster has been created using [another Terraform Module](https://github.com/sumitsarkar/terraform-aws-ecs-cluster). 

It is recommended to use a terraform state storage (I prefer [S3](https://aws.amazon.com/s3/)).

## Usage

Make a file `terraform.tfvars` in the root of the repo and add the variables.

```hcl
environment = "integration"
vpc_id = "vpc-12345678"
cluster_name = "testCluster"
alb_listener_rule_arns = [
  "arn:aws:elasticloadbalancing:eu-west-1:880016731919:listener/app/bkbn-test-external/ed28eb87d2aed3a7/8d3ccec655b5d49d",
  "arn:aws:elasticloadbalancing:eu-west-1:880016731919:listener/app/bkbn-test-external/ed28eb87d2aed3a7/1d504add06f7fcc5"]
rule_type = "path-pattern"
rule_value = "/*"
rule_priority = "10"
health_check_path = "/"
service_port = 80
cpu = 100
memory = 512
log_group = "log_group_name"
```

The terraform modules used inside require two more variables: `image_url` and `service_name`. However we haven't set that in the previous file because this sample does the job of setting up the ECR and uploading a docker image to the repository.

The `deploy.sh` file is responsible for creating the ECR if it doesn't exist already, re-tags the local docker image for uploading to the ECR and then uploads to the ECR. If you are using Docker Hub, then you'll need to modify the script accordingly.

Run the `deploy.sh` with the environment variables set. For example,

```bash
SERVICE_NAME=nginx IMAGE=nginx IMAGE_TAG=1.13.0-alpine bash push_image.sh
```

## Task Role and Policies

The `task_role.tf` sets up an IAM task role and uses that to create the task definition. The file can be modified to add more IAM policies to the task role.


**Note:**
I couldn't figure out a way to use `local-exec` while creating an ECR repository using terraform. Lost a bit of time to do it on windows. Might be possible in Linux. Make a pull request if you could solve it for all platforms.