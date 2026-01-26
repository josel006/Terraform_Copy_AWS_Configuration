# Terraform_Copy_AWS_Configuration
## Syncing Existing AWS Changes into Terraform State

This exercise demonstrates how Terraform can detect and reconcile configuration changes made directly in the AWS Console, without modifying or redeploying existing infrastructure.

The goal is to understand how terraform plan -refresh-only and terraform apply -refresh-only work to keep the Terraform state file (tfstate) aligned with the real AWS environment.

## Overview

- An S3 bucket was originally created using Terraform

- A new tag was later added directly from the AWS Console

- Terraform is then used to detect and record that external change

This workflow is common in real-world environments where:

- Changes may be made manually for troubleshooting or audits

- Terraform must remain the source of truth

## Initial Terraform Deployment

The S3 bucket was created using Terraform.

<img width="405" height="195" alt="image" src="https://github.com/user-attachments/assets/165347fa-0209-490d-987a-67c815e28562" />

Terraform successfully deployed the resource and tracked it in the Terraform state file.

<img width="1687" height="409" alt="image" src="https://github.com/user-attachments/assets/dbaaab42-224a-44fa-8f45-0de583a73983" />

## Manual Change in AWS Console

A new tag was added to the same S3 bucket directly from the AWS Console.

<img width="1455" height="365" alt="image" src="https://github.com/user-attachments/assets/27c9c15a-2cd0-4f1b-a145-951695eed9e4" />

At this point:

- AWS reflects the new tag

- Terraform configuration files have not been updated

- Terraform state is now out of sync with AWS

## Detecting the Change with Terraform

To detect the drift, the following command was executed:

terraform plan -refresh-only

## What this does:

- Terraform queries AWS

- Compares real infrastructure with the current Terraform state

- Displays detected differences without planning any infrastructure changes

<img width="1250" height="473" alt="image" src="https://github.com/user-attachments/assets/fb9d2d3b-c325-4faf-b089-dd6d44d48193" />

## Updating the Terraform State

To update the state file without modifying infrastructure, run:

terraform apply -refresh-only

<img width="988" height="325" alt="image" src="https://github.com/user-attachments/assets/95166c83-7dea-45be-bbd9-0e1bb75f608c" />

After typing yes to confirm:

- Terraform state is now back in sync with AWS

- No AWS resources are created, modified, or destroyed

- Future Terraform plans will reflect the updated state

<img width="1217" height="716" alt="image" src="https://github.com/user-attachments/assets/ffaa4b5b-1eb4-40f4-99a4-30a39a3b4c99" />

## Key Takeaways

- terraform plan -refresh-only is used to detect drift

- terraform apply -refresh-only is used to sync the state file

- Refresh-only operations do not modify infrastructure

- Terraform configuration files must still be updated manually if the change should be managed as code
