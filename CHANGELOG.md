# CHANGELOG

## 0.1.3

* dropped CentOS 5 support

## 0.1.2

* added master multimaster (salt::minion::master can be a string, for backward compatibility, or an array)
* added multimaster related variables:
  * **master_type**
  * **master_failback**
  * **random_master**
* added **master_port** variable
* added Ubuntu 14.04 and Ubuntu16.04 support

## 0.1.1

* minion_id under puppet control

## 0.1.0

* initial release
