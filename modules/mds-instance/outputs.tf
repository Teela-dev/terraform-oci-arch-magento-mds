## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "private_ip" {
  value = data.oci_mysql_mysql_db_system.MDSinstance_to_use.ip_address
}
