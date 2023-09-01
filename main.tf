# Configure the Alicloud Provider

provider "alicloud" {

  region = "ALICLOUD_REGION"
  skip_region_validation = true
  access_key = "ALICLOUD_ACCESS_KEY"
  secret_key = "ALICLOUD_SECRET_KEY"

}

data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.t6-c2m1.large"
  }

data "alicloud_images" "default" {
  name_regex  = "^ubuntu"
  most_recent = true
  owners      = "system"
}

# Create a web server
resource "alicloud_instance" "web" {
  image_id             = data.alicloud_images.default.images.0.id
  instance_type        = data.alicloud_instance_types.default.instance_types.0.id
  system_disk_category = "cloud_efficiency"
  security_groups      = ["${alicloud_security_group.default.id}"]
  instance_name        = "web"
  vswitch_id           = "vsw-abc12345"
}

# Create security group
resource "alicloud_security_group" "default" {
  name        = "default"
  description = "default"
  vpc_id      = "vpc-abc12345"
  }



