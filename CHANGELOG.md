# CHANGELOG

## 0.1.5

* added Ubuntu 18.04 support
* added suport for:
  - saltstack::ssh
  - saltstack::api
  - saltstack::cloud

## 0.1.4

* repo is downloaded using the download type from **eyplib 0.1.10**

## 0.1.3

* dropped CentOS 5 support

## 0.1.2

* added master multimaster (salt::minion::master can be a string, for backward compatibility, or an array)
* added multimaster related variables:
  * **master_type**
  * **master_failback**
  * **random_master**
* added **master_port** variable
* added Ubuntu 14.04 and Ubuntu 16.04 support

## 0.1.1

* minion_id under puppet control

## 0.1.0

* initial release
