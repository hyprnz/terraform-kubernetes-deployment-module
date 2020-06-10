# Terraform Kubernetes Deployment Module

This module intends to create both AWS and Kubernetes resources for a Kubernetes Deployment.

Current this module can create a RDS instance and store the database parameters in a Kubernetes secret.

The name of the secret is defined by appending `-db` to the `app_name` variable, i.e. if `app_name`
has the value of `foo-service`, the Kubernetes secret will be named `foo-service-db`

The secret has 4 key value pairs

1. username - user of the RDS instance
1. password - users password
1. dbname - the database name
1. endpoint - the endpoint of the RDS instance (includes port number)
1. url - the connection url to the RDS database

# Example
The example `example/rds_datastore` depends on the example of `terraform-eks-module project` that generates the EKS cluster this example uses.

## Providers

| Name | Version |
|------|---------|
| aws | ~>2.19 |
| kubernetes | ~>1.8 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| app\_name | The name of the Kubernetes service | `any` | n/a | yes |
| eks\_cluster\_name | Name of EKS cluster | `any` | n/a | yes |
| create\_rds\_instance | Controls if an RDS instance should be provisioned and integrated with the Kubernetes deployment. | `bool` | `false` | no |
| create\_s3\_bucket | Controls if an S3 bucket should be provisioned | `bool` | `false` | no |
| datastore\_tags | Additional tags to add to all datastore resources | `map(string)` | `{}` | no |
| enable\_datastore\_module | Enables the data store module that can provision data storage resources | `bool` | `false` | no |
| namespace | The namespace of the Kubernetes resources | `string` | `"default"` | no |
| rds\_allocated\_storage | Amount of storage allocated to RDS instance | `number` | `10` | no |
| rds\_database\_name | The database name. Can only contain alphanumeric characters and cannot be a database reserved word | `string` | `""` | no |
| rds\_enable\_performance\_insights | Controls the enabling of RDS Performance insights. Default to `true` | `bool` | `true` | no |
| rds\_enable\_storage\_encryption | Specifies whether the DB instance is encrypted | `bool` | `false` | no |
| rds\_engine | The Database engine for the rds instance | `string` | `"postgres"` | no |
| rds\_engine\_version | The version of the database engine | `number` | `11.4` | no |
| rds\_identifier | Identifier of rds instance | `string` | `""` | no |
| rds\_instance\_class | The instance type to use | `string` | `"db.t3.small"` | no |
| rds\_iops | The amount of provisioned IOPS. Setting this implies a storage\_type of 'io1' | `number` | `0` | no |
| rds\_max\_allocated\_storage | The upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Configuring this will automatically ignore differences to `allocated_storage`. Must be greater than or equal to `allocated_storage` or `0` to disable Storage Autoscaling. | `number` | `0` | no |
| rds\_monitoring\_interval | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `0` | no |
| rds\_monitoring\_role\_arn | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring\_interval is non-zero. | `string` | `""` | no |
| rds\_password | RDS database password | `string` | `""` | no |
| rds\_security\_group\_ids | A List of security groups to bind to the rds instance | `list(string)` | `[]` | no |
| rds\_storage\_encryption\_kms\_key\_arn | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage\_encrypted is set to true and kms\_key\_id is not specified the default KMS key created in your account will be used | `string` | `""` | no |
| rds\_subnet\_group | Subnet group for RDS instances | `string` | `""` | no |
| rds\_tags | Additional tags for the RDS instance | `map(string)` | `{}` | no |
| s3\_bucket\_K8s\_worker\_iam\_role\_arn | The arn of the Kubernetes worker role that allows a service to assume the role to access the bucket and options | `string` | `""` | no |
| s3\_bucket\_name | The name of the bucket | `string` | `""` | no |
| s3\_bucket\_namespace | The namespace of the bucket - intention is to help avoid naming collisions | `string` | `""` | no |
| s3\_enable\_versioning | If versioning should be configured on the bucket | `bool` | `true` | no |
| s3\_tags | Additional tags to be added to the s3 resources | `map` | `{}` | no |

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
| datastore\_s3\_bucket\_name | The name of the s3 bucket |
| datastore\_s3\_bucket\_role | The role that has access to the bucket |

