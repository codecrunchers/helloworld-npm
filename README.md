# Pipeline Showcase

## App
We deploy a Hello World App, which decrypts and prints the value of a key stored in Parameter Store, encrytped by KMS.

## Arch
We deploy a node configured EC2 instance in two AZ's accessed vi an ELB.  This could be extended easily to a auto-scaled ec2 launch configuration for reliability engineering.

## Packaging
Quick and dirty, using npm pack and checking .modules into repo.  Will push to nexus and is pulled and rebuilt on the target machine via user data.

## Env Vars
* GREETING - will display differntly in each env it is deploye to, while never referencing envs directly in code.

   This will be available in all environments, with the env appended. Eg "Hello From QA|Staging|Prod".  To encrypt and export to [Parameter Store](https://aws.amazon.com/blogs/compute/managing-secrets-for-amazon-ecs-applications-using-parameter-store-and-iam-roles-for-tasks/) use your default VPC key - available once you are logged in.

```
➜  app git:(master) aws ssm put-parameter --name app.node.pipeline.qa.greeting --value "Hello From QA" --type SecureString --region eu-west-1
➜  app git:(master) aws ssm put-parameter --name app.node.pipeline.staging.greeting --value "Hello From Staging" --type SecureString --region eu-west-1
➜  app git:(master) aws ssm put-parameter --name app.node.pipeline.prod.greeting --value "Hello From Prod" --type SecureString --region eu-west-1

```
Secrets are now encrypted and stored.


