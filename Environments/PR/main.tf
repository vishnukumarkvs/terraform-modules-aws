module "db_instance" {
  source = "../../Modules/rds-db-instance" # Update with the correct path to your module

  identifier             = "my-db-instance"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "5.7"
  db_username            = "mydbuser"
  db_subnet_group_name   = "default"
  security_group_ids     = ["sg-12345678", "sg-87654321"]
  db_parameter_group_name = "awsre-rds-para-group"
  is_publicly_accesible  = false
  is_skip_final_snapshot = true
  default_tags           = {
    Environment = "dev"
    Owner       = "myname"
  }

  create_parameter_group = false
  # family                = "mysql5.7"
  # parameter_group_settings = {
  #   "character_set_server" = "utf8mb4"
  #   "collation_server"    = "utf8mb4_unicode_ci"
  # }

  create_db_subnet_group = false
  # subnet_ids            = ["subnet-12345678", "subnet-87654321"]

  db_secret_name        = "my-db-secret-01"
  recovery_window_in_days = 0
}

module "rds_serverless_v2" {
  source = "../../Modules/rds-serverless-v2"


  cluster_identifier                 = "my-cluster"
  engine                             = "aurora-postgresql"
  engine_version                     = "13.6"
  database_name                      = "mydatabase"
  master_username                    = "admin"
  security_group_ids                 = ["sg-xxxxxxxx", "sg-yyyyyyyy"]
  max_capacity                       = 2
  min_capacity                       = 1
  db_secret_name                     = "my-db-secret"
  recovery_window_in_days            = 0
  db_username                        = "dbuser"
  db_subnet_group_name               = "my-db-subnet-group"
  rds_cluster_parameter_group_name   = "my-cluster-param-group"


  create_db_subnet_group             = false
  # subnet_ids                         = ["subnet-xxxxxxx", "subnet-yyyyyyy"]

  create_rds_cluster_parameter_group = false
  # family                             = "aurora5.6"
  # parameters                         = [{ name = "time_zone", value = "UTC", apply_method = "immediate" }]

  default_tags                       = { "Environment" = "dev", "Project" = "MyProject" }

}

module "network_load_balancer" {
  source = "../../Modules/nlb" # Adjust the source path

  name                              = "my-nlb"
  is_internal                        = false
  lb_type                           = "application"
  subnet_ids                        = ["subnet-12345678", "subnet-87654321"]
  is_enable_cross_zone_load_balancing = true
  is_deletion_protected              = false
  enable_access_logs                = false
  # auto_create_s3_log_bucket         = true
  # nlb_access_log_bucket_name        = "my-access-logs-bucket"
  default_tags = {
    Environment = "development"
    Project     = "my-project"
  }
}

# Standard Queue
module "standard_queue" {
  source = "../../Modules/sqs"

  queue_name               = "my-standard-queue"
  queue_type               = "standard"
  delay_seconds            = 10
  max_message_size         = 1024
  message_retention_seconds = 86400
  receive_wait_time_seconds = 5
}

# FIFO Queue
module "fifo_queue" {
  source = "../../Modules/sqs"

  queue_name               = "my-fifo-queue"
  queue_type               = "fifo"
  delay_seconds            = 20
  max_message_size         = 2048
  message_retention_seconds = 1209600
  receive_wait_time_seconds = 10
}

# FIFO Queue with Dead-letter Queue
module "fifo_queue_with_deadletter" {
  source = "../../Modules/sqs"

  queue_name               = "my-fifo-queue-with-deadletter"
  queue_type               = "fifo"
  create_deadletter_queue  = true
  delay_seconds            = 30
  max_message_size         = 4096
  message_retention_seconds = 172800
  receive_wait_time_seconds = 20
  max_receive_count        = 3
}

module "api" {
  source = "../../Modules/apigw/rest_api"
  name = "btest-api"
  description = "example test api"
  swagger_file = "./scripts/swagger.json"
  endpoint_type = "REGIONAL"
}

module "stage"{
  source = "../../Modules/apigw/stage"
  rest_api_id = module.api.api_gateway_rest_api_id
  stage_name = "test-stage-111"
}

module "api_gateway_resources" {
  source = "../../Modules/apigw/usageplan_key" # Replace with the actual path to your module

  # Pass values to the module variables
  api_key_name                     = "MyApiKey"
  apigw_usage_plan_name             = "MyUsagePlan"
  api_key_usage_plan_quota_limit    = 1000
  api_key_usage_plan_quota_period   = "MONTH"
  api_key_usage_plan_burst_limit    = 5
  api_key_usage_plan_rate_limit     = 2
  api_gateway_rest_api_id           = module.api.api_gateway_rest_api_id
  api_gateway_deployment_stage_name = module.stage.stage_name
}