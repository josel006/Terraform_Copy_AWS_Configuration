/*
(1) This demo will show the state file after creating a resource. 
(2) We will demo the behavior when we manually change an attribute that is tied to an argument that is explicitly defined in the terraform configuration file.
(3) Lastly, we will demonstrate the terraform plan -refresh-only and terraform apply -refresh-only
*/


resource "aws_s3_bucket" "example" {
  bucket = "my-bucket-12345abcd"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

