module "s3" {
    source = "../modules/s3"
    name = var.name
    region = var.region 


}
module "cloudtrail" {
    source = "../modules/cloudtrail"
    name = var.name
    test-trail-s3-name= module.s3.test-trail-s3-name
    test-trail-s3-policy = module.s3.test-trail-s3-policy
}