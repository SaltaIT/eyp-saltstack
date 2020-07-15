# CHANGELOG

## 0.2.0

* INCOMPATIBLE CHANGE:
  - dropped **SuSE** support
  - dropped support for legacy puppet versions (3.8)
* Added **Ubuntu 20.04** support
* Added **CentOS 8** support
* Added **Debian 8**, **Debian 9** and **Debian 10** support


## 0.1.18

* bugfix GPG key

## 0.1.17

* added variable to chose between http and https repos

## 0.1.16

* added support for **SaltStack 2019.2** on **CentOS 6** and **CentOS 7**

## 0.1.15

* added support for **CentOS 5**

## 0.1.14

* added static grains for saltstak::minion

## 0.1.13

* bugfix SaltStack 2018.3

## 0.1.12

* added SaltStack 2018.3

## 0.1.11

* added deleted state for salt keys
* added version_minor to install a specific salt version

## 0.1.10

* reorder minion dependencies

## 0.1.9

* added SLES 11.3 support
* added **manage_config** to **saltstack::minion**

## 0.1.8

* added SLES 12.3 support

## 0.1.7

* added version selector via **saltstack::repo**
  - latest (latest available, changes among time)
  - 2017.7
  - 2016.11
  - 2016.3

## 0.1.6

* **salt::cloud**:
  - bugfix log_datefmt
  - flag to manage vSphere dependencies (true by default)
* **salt::api**:
  - added **saltstack::api::rest_timeout** (default: 7200)
* **salt::master**:
  - added keys management
  - acl management for salt-master via eAuth

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
