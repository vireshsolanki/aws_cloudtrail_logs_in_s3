resource "aws_cloudtrail" "test-trail" {
    depends_on = [ var.test-trail-s3-policy ]
   is_multi_region_trail = true
  event_selector {
    include_management_events = true
    read_write_type           = "All"
  }
  

  name                          = var.name
  s3_bucket_name                = "${var.test-trail-s3-name}"
  s3_key_prefix                 = ""
  include_global_service_events = true
  enable_log_file_validation = true
 
}

