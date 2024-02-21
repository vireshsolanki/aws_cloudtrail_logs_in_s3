
---

# CloudTrail to check logs of user in AWS account

This project focuses on creating the S3 bucket and CloudTrail for management events using Terraform.

## Table of Contents

1. [Introduction](#introduction)
2.  [Prerequisites](#prerequisites)
3. [Usage](#usage)
4. [Modules](#modules)
5. [Variables](#variables)
6. [Contributing](#contributing)

## Introduction

In many AWS environments, it's crucial to have fine-grained control over resource creation permissions. This project demonstrates creation of Cloutrail (management event)and S3 bucket. 


## Prerequisites

Before using this project, ensure you have the following:

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
- AWS credentials configured on your system.
- Basic understanding of S3 , CloudTrail and Terraform.

## Usage

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/vireshsolanki/aws_cloudtrail_logs_in_s3.git
   ```

2. Navigate to the project directory:

   ```bash
   cd creation
   ```

3. Initialize the Terraform configuration:

   ```bash
   terraform init
   ```

4. Customize the `terraform.tfvars` file to specify the desired region,name.
    ``` bash
      name = "test-cltrail"
      region = "ap-southeast-1"

    ```
5. Review the Terraform configuration files to ensure they meet your requirements.

6. Apply the changes to create the IAM policy:

   ```bash
   terraform apply
   ```

## Modules

This project consists of the following modules:

1. `s3`: Creates S3 bucket.
2. `cloudtrail`: Creates CloudTrail .
   ```bash
   resource "aws_cloudtrail" "test-trail" {
    depends_on = [ var.test-trail-s3-policy ]
   is_multi_region_trail = true
     event_selector {
    include_management_events = true #this for the management events
    read_write_type           = "All"
     }

   ```
   
## Variables

The project uses the following variables, which can be customized in the `terraform.tfvars` file:

- `name`: It will have your CloudTrail name.
- `region`: The allowed AWS region for S3 bucket.
## Contributing

Contributions to this project are welcome. Feel free to submit issues, feature requests, or pull requests.
