# Pipeline Showcase

## App
We deploy a Hello World App, which decrypts and prints the value of a key stored in Parameter Store, encrytped by KMS.

## Arch
We deploy a node configured EC2 instance, locked down to port 80 only.

## Env Vars
* GREETING

   This will be available in all environments, with the env appended. Eg "Hello From QA|Staging|Prod".  To encrypt and export to [Parameter Store](https://aws.amazon.com/blogs/compute/managing-secrets-for-amazon-ecs-applications-using-parameter-store-and-iam-roles-for-tasks/) use your default VPC key - available once you are logged in.

```
➜  app git:(master) aws ssm put-parameter --name app.node.pipeline.qa.greeting --value "Hello From QA" --type SecureString --region eu-west-1
➜  app git:(master) aws ssm put-parameter --name app.node.pipeline.staging.greeting --value "Hello From Staging" --type SecureString --region eu-west-1
➜  app git:(master) aws ssm put-parameter --name app.node.pipeline.prod.greeting --value "Hello From Prod" --type SecureString --region eu-west-1

```
Secrets are now encrypted and stored.


