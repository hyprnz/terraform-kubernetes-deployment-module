# Terraform Kubernetes Deployment Module

This module intends to create both AWS and Kubernetes resources for a Kubernetes Deployment.

Current this module supports the following data stores"

* RDS -  creates a RDS instance and store the database parameters in a Kubernetes secret.
* S3 - creates a bucket and role to access bucket. Role can be assumed using Kube2Iam or similar

The name of the secret is defined by appending `-db` to the `app_name` variable, i.e. if `app_name`
has the value of `foo-service`, the Kubernetes secret will be named `foo-service-db`

The secret has 4 key value pairs

1. username - user of the RDS instance
1. password - users password
1. dbname - the database name
1. endpoint - the endpoint of the RDS instance (includes port number)
1. url - the connection url to the RDS database

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| app\_name | The name of the Kubernetes service | string | n/a | yes |
| eks\_cluster\_name | Name of EKS cluster | string | n/a | yes |
| create\_s3\_bucket | Controls if an S3 bucket should be provisioned | string | `"false"` | no |
| data\_store\_name | The name for the datastore resources. Should represent the service name. Can only contain alphanumeric characters | string | `""` | no |
| datastore\_tags | Additional tags to add to all datastore resources | map | `<map>` | no |
| enable\_datastore\_module | Enables the data store module that can provision data storage resources | string | `"false"` | no |
| enable\_rds | Controls if an RDS instance should be provisioned and integrated with the service. | string | `"false"` | no |
| namespace | The namespace of the Kubernetes resources | string | `"default"` | no |
| rds\_enable\_storage\_encryption | Specifies whether the DB instance is encrypted | string | `"false"` | no |
| rds\_engine | The Database engine for the rds instance | string | `"postgres"` | no |
| rds\_engine\_version | The version of the database engine | string | `"11.4"` | no |
| rds\_identifier | Identifier of rds instance | string | `""` | no |
| rds\_instance\_class | The instance type to use | string | `"db.t3.small"` | no |
| rds\_password | RDS database password | string | `""` | no |
| rds\_security\_group\_ids | A List of security groups to bind to the rds instance | list | `<list>` | no |
| rds\_storage\_encryption\_kms\_key\_arn | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used | string | `""` | no |
| rds\_subnet\_group | Subnet group for RDS instances | string | `""` | no |
| rds\_tags | Additional tags for the RDS instance | map | `<map>` | no |
| s3\_bucket\_K8s\_worker\_iam\_role\_arn | The arn of the Kubernetes worker role that allows a service to assume the role to access the bucket and options | string | `""` | no |
| s3\_bucket\_namespace | The namespace of the bucket - intention is to help avoid naming collisions | string | `""` | no |
| s3\_enable\_versioning | If versioning should be configured on the bucket | string | `"true"` | no |
| s3\_tags | Additional tags to be added to the s3 resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_config | Kube config file of the current cluster |
| datastore\_rds\_db\_name | The RDS database name |
| datastore\_rds\_db\_url | The RDS connection url in the format of `engine`://`user`:`password`@`endpoint`/`db_name` |
| datastore\_rds\_db\_user | The RDS instance ID |
| datastore\_rds\_instance\_address | The address of the RDS instance |
| datastore\_rds\_instance\_arn | The ARN of the RDS instance |
| datastore\_rds\_instance\_endpoint | The connection endpoint |
| datastore\_rds\_instance\_id | The RDS instance ID |

