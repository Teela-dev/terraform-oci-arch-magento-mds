## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

module "oci-arch-magento" {
  source                    = "github.com/oracle-devrel/terraform-oci-arch-magento"
  tenancy_ocid              = var.tenancy_ocid
  vcn_id                    = oci_core_virtual_network.magento_mds_vcn.id
  numberOfNodes             = var.numberOfNodes
  availability_domain_name  = var.availability_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availability_domain_name
  compartment_ocid          = var.compartment_ocid
  image_id                  = lookup(data.oci_core_images.InstanceImageOCID.images[0], "id")
  shape                     = var.node_shape
  label_prefix              = var.label_prefix
  ssh_authorized_keys       = var.ssh_public_key
  mds_ip                    = module.mds-instance.mysql_db_system.ip_address
  magento_subnet_id         = oci_core_subnet.magento_subnet.id
  lb_subnet_id              = var.numberOfNodes > 1 ? oci_core_subnet.lb_subnet_public[0].id : ""
  bastion_subnet_id         = (var.numberOfNodes > 1 && var.use_bastion_service == false) ? oci_core_subnet.bastion_subnet_public[0].id : ""
  fss_subnet_id             = var.numberOfNodes > 1 && var.use_shared_storage ? oci_core_subnet.fss_subnet_private[0].id : ""
  admin_password            = var.admin_password
  admin_username            = var.admin_username
  magento_schema            = var.magento_schema
  magento_name              = var.magento_name
  magento_password          = var.magento_password
  magento_admin_password    = var.magento_admin_password
  magento_admin_email       = var.magento_admin_email
  magento_backend_frontname = var.magento_backend_frontname
  display_name              = var.magento_instance_name
  flex_shape_ocpus          = var.node_flex_shape_ocpus
  flex_shape_memory         = var.node_flex_shape_memory
  lb_shape                  = var.numberOfNodes > 1 ? var.lb_shape : ""
  flex_lb_min_shape         = var.numberOfNodes > 1 ? var.flex_lb_min_shape : ""
  flex_lb_max_shape         = var.numberOfNodes > 1 ? var.flex_lb_max_shape : ""
  use_bastion_service       = var.use_bastion_service
  bastion_image_id          = lookup(data.oci_core_images.InstanceImageOCID2.images[0], "id")
  bastion_shape             = var.bastion_shape
  bastion_flex_shape_ocpus  = var.bastion_flex_shape_ocpus
  bastion_flex_shape_memory = var.bastion_flex_shape_memory
  bastion_service_region    = var.numberOfNodes > 1 ? var.region : ""
  defined_tags              = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
  elastic_search_ocpus      = var.elastic_search_flex_shape_ocpus
  elastic_search_memory     = var.elastic_search_flex_shape_memory
  elastic_search_shape      = var.elastic_search_instance_shape
  rabbitmq_ocpus            = var.rabbitmq_flex_shape_ocpus
  rabbitmq_memory           = var.rabbitmq_flex_shape_memory
  magento_version           = var.magento_version
  varnish_ocpus             = var.varnish_flex_shape_ocpus
  varnish_memory            = var.varnish_flex_shape_memory
  admin_instance_shape      = var.admin_instance_shape
  admin_instance_ocpus      = var.admin_instance_shape_ocpus
  admin_instance_memory     = var.admin_instance_shape_memory
  redis_version             = var.redis_version
  redis_prefix              = var.redis_prefix
  redis_port                = var.redis_port
  redis_ocpus               = var.redis_flex_shape_ocpus
  redis_memory              = var.redis_flex_shape_memory
  redis_port2               = var.redis_port2
  sentinel_port             = var.sentinel_port


}

