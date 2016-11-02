#
# Author:: Seth Chisamore (<schisamo@chef.io>)
# Cookbook Name:: java
# Attributes:: default
#
# Copyright 2010-2015, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# default jdk attributes
default['java']['jdk_version'] = '8'
default['java']['arch'] = node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'i586'
default['java']['openjdk_packages'] = []
default['java']['openjdk_version'] = nil
default['java']['accept_license_agreement'] = true
default['java']['set_default'] = true
default['java']['alternatives_priority'] = 1062
default['java']['set_etc_environment'] = false
default['java']['use_alt_suffix'] = true
default['java']['reset_alternatives'] = true

# the following retry parameters apply when downloading oracle java
default['java']['ark_retries'] = 0
default['java']['ark_retry_delay'] = 2
default['java']['ark_timeout'] = 600
default['java']['ark_download_timeout'] = 600

case node['platform_family']
when 'windows'
  default['java']['install_flavor'] = 'windows'
  default['java']['windows']['url'] = nil
  default['java']['windows']['checksum'] = nil
  default['java']['windows']['package_name'] = 'Java(TM) SE Development Kit 7 (64-bit)'
  default['java']['windows']['public_jre_home'] = nil
  default['java']['windows']['owner'] = 'administrator'
when 'mac_os_x'
  default['java']['install_flavor'] = 'homebrew'
else
  default['java']['install_flavor'] = 'openjdk'
end

case node['java']['install_flavor']
when 'ibm', 'ibm_tar'
  default['java']['ibm']['url'] = nil
  default['java']['ibm']['checksum'] = nil
  default['java']['ibm']['accept_ibm_download_terms'] = false
  default['java']['java_home'] = '/opt/java'

  default['java']['ibm']['6']['bin_cmds'] = %w(appletviewer apt ControlPanel extcheck HtmlConverter idlj jar jarsigner
                                               java javac javadoc javah javap javaws jconsole jcontrol jdb jdmpview
                                               jrunscript keytool native2ascii policytool rmic rmid rmiregistry
                                               schemagen serialver tnameserv wsgen wsimport xjc)

  default['java']['ibm']['7']['bin_cmds'] = node['java']['ibm']['6']['bin_cmds'] + %w(pack200 unpack200)
when 'oracle_rpm'
  # type of java RPM : jdk or jre
  default['java']['oracle_rpm']['type'] = 'jdk'

  # optional, can be overriden to pin to a version different
  # from the up-to-date.
  default['java']['oracle_rpm']['package_version'] = nil

  # optional, some distros re-package the official Oracle's RPM
  # with a different name
  default['java']['oracle_rpm']['package_name'] = nil

  # set the JAVA_HOME path, it may be overriden
  # when a package version is provided.
  default['java']['java_home'] = '/usr/java/latest'
end

# if you change this to true, you can download directly from Oracle
default['java']['oracle']['accept_oracle_download_terms'] = false

# direct download paths for oracle, you have been warned!

# jdk6 attributes
default['java']['jdk']['6']['bin_cmds'] = %w(appletviewer apt ControlPanel extcheck HtmlConverter idlj jar jarsigner
                                             java javac javadoc javah javap javaws jconsole jcontrol jdb jhat
                                             jinfo jmap jps jrunscript jsadebugd jstack jstat jstatd jvisualvm
                                             keytool native2ascii orbd pack200 policytool rmic rmid rmiregistry
                                             schemagen serialver servertool tnameserv unpack200 wsgen wsimport xjc)

# x86_64
default['java']['jdk']['6']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin'
default['java']['jdk']['6']['x86_64']['checksum'] = '6b493aeab16c940cae9e3d07ad2a5c5684fb49cf06c5d44c400c7993db0d12e8'

# i586
default['java']['jdk']['6']['i586']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-i586.bin'
default['java']['jdk']['6']['i586']['checksum'] = 'd53b5a2518d80e1d95565f0adda54eee229dc5f4a1d1a3c2f7bf5045b168a357'

# jdk7 attributes

default['java']['jdk']['7']['bin_cmds'] = %w(appletviewer apt ControlPanel extcheck idlj jar jarsigner java javac
                                             javadoc javafxpackager javah javap javaws jcmd jconsole jcontrol jdb
                                             jhat jinfo jmap jps jrunscript jsadebugd jstack jstat jstatd jvisualvm
                                             keytool native2ascii orbd pack200 policytool rmic rmid rmiregistry
                                             schemagen serialver servertool tnameserv unpack200 wsgen wsimport xjc)

# Oracle doesn't seem to publish SHA256 checksums for Java releases, so we use MD5 instead.
# Official checksums for the latest release can be found at https://www.oracle.com/webfolder/s/digest/7u75checksum.html

# x86_64
default['java']['jdk']['7']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-linux-x64.tar.gz'
default['java']['jdk']['7']['x86_64']['checksum'] = '6f1f81030a34f7a9c987f8b68a24d139'

# i586
default['java']['jdk']['7']['i586']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-linux-i586.tar.gz'
default['java']['jdk']['7']['i586']['checksum'] = 'e4371a4fddc049eca3bfef293d812b8e'

# jdk8 attributes

default['java']['jdk']['8']['bin_cmds'] = %w(appletviewer apt ControlPanel extcheck idlj jar jarsigner java javac
                                             javadoc javafxpackager javah javap javaws jcmd jconsole jcontrol jdb
                                             jdeps jhat jinfo jjs jmap jmc jps jrunscript jsadebugd jstack
                                             jstat jstatd jvisualvm keytool native2ascii orbd pack200 policytool
                                             rmic rmid rmiregistry schemagen serialver servertool tnameserv
                                             unpack200 wsgen wsimport xjc)

# Oracle just started publishing SHA256 checksums for Java releases with 8u51, so we use MD5 instead.
# Official checksums for the latest release can be found at https://www.oracle.com/webfolder/s/digest/8u60checksum.html

# x86_64
default['java']['jdk']['8']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz'
default['java']['jdk']['8']['x86_64']['checksum'] = '467f323ba38df2b87311a7818bcbf60fe0feb2139c455dfa0e08ba7ed8581328'

# i586
default['java']['jdk']['8']['i586']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-i586.tar.gz'
default['java']['jdk']['8']['i586']['checksum'] = 'b11212ef06235296cad2f9b80a22f2d853a2d2f66ce55b993eb686e5a2da365d'

default['java']['oracle']['jce']['enabled'] = false
default['java']['oracle']['jce']['8']['url'] = 'http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip'
default['java']['oracle']['jce']['8']['checksum'] = 'f3020a3922efd6626c2fff45695d527f34a8020e938a49292561f18ad1320b59'
default['java']['oracle']['jce']['7']['url'] = 'http://download.oracle.com/otn-pub/java/jce/7/UnlimitedJCEPolicyJDK7.zip'
default['java']['oracle']['jce']['7']['checksum'] = '7a8d790e7bd9c2f82a83baddfae765797a4a56ea603c9150c87b7cdb7800194d'
default['java']['oracle']['jce']['6']['url'] = 'http://download.oracle.com/otn-pub/java/jce_policy/6/jce_policy-6.zip'
default['java']['oracle']['jce']['6']['checksum'] = 'd0c2258c3364120b4dbf7dd1655c967eee7057ac6ae6334b5ea8ceb8bafb9262'
default['java']['oracle']['jce']['home'] = '/opt/java_jce'




#######tomcat####
default['opsworks_java'] = {}

default['opsworks_java']['jvm'] = 'openjdk'
default['opsworks_java']['jvm_version'] = '7'
default['opsworks_java']['jvm_options'] = ''
default['opsworks_java']['java_app_server'] = 'tomcat'
default['opsworks_java']['java_app_server_version'] = '7.0'

default['opsworks_java']['jvm_pkg'] = {}
default['opsworks_java']['jvm_pkg']['use_custom_pkg_location'] = false
default['opsworks_java']['jvm_pkg']['custom_pkg_location_url_debian'] = 'http://aws.amazon.com/'
default['opsworks_java']['jvm_pkg']['custom_pkg_location_url_rhel'] = 'https://aws.amazon.com/'
case node[:platform_family]
when 'debian'
  default['opsworks_java']['jvm_pkg']['name'] = "openjdk-#{node['opsworks_java']['jvm_version']}-jdk"
when 'rhel'
  default['opsworks_java']['jvm_pkg']['name'] = "java-1.#{node['opsworks_java']['jvm_version']}.0-openjdk-devel"
end
default['opsworks_java']['jvm_pkg']['java_home_basedir'] = '/usr/local'

default['opsworks_java']['datasources'] = {}

default['opsworks_java']['tomcat']['base_version'] = node['opsworks_java']['java_app_server_version'].to_i

if rhel7?
  default['opsworks_java']['tomcat']['service_name'] = "tomcat"
  default['opsworks_java']['tomcat']['catalina_base_dir'] = "/etc/tomcat"
  default['opsworks_java']['tomcat']['webapps_base_dir'] = "/var/lib/tomcat/webapps"
  default['opsworks_java']['tomcat']['lib_dir'] = "/usr/share/tomcat/lib"
else
  default['opsworks_java']['tomcat']['service_name'] = "tomcat#{node['opsworks_java']['tomcat']['base_version']}"
  default['opsworks_java']['tomcat']['catalina_base_dir'] = "/etc/tomcat#{node['opsworks_java']['tomcat']['base_version']}"
  default['opsworks_java']['tomcat']['webapps_base_dir'] = "/var/lib/tomcat#{node['opsworks_java']['tomcat']['base_version']}/webapps"
  default['opsworks_java']['tomcat']['lib_dir'] = "/usr/share/tomcat#{node['opsworks_java']['tomcat']['base_version']}/lib"
end

default['opsworks_java']['tomcat']['port'] = 8080
default['opsworks_java']['tomcat']['secure_port'] = 8443
default['opsworks_java']['tomcat']['ajp_port'] = 8009
default['opsworks_java']['tomcat']['shutdown_port'] = 8005
default['opsworks_java']['tomcat']['uri_encoding'] = 'UTF-8'
default['opsworks_java']['tomcat']['unpack_wars'] = true
default['opsworks_java']['tomcat']['auto_deploy'] = true
default['opsworks_java']['tomcat']['java_opts'] = node['opsworks_java']['jvm_options']
default['opsworks_java']['tomcat']['userdatabase_pathname'] = 'conf/tomcat-users.xml'
default['opsworks_java']['tomcat']['use_ssl_connector'] = false
default['opsworks_java']['tomcat']['use_threadpool'] = false
default['opsworks_java']['tomcat']['threadpool_max_threads'] = 150
default['opsworks_java']['tomcat']['threadpool_min_spare_threads'] = 4
default['opsworks_java']['tomcat']['connection_timeout'] = 20000

default['opsworks_java']['tomcat']['java_shared_lib_dir'] = '/usr/share/java'
default['opsworks_java']['tomcat']['context_dir'] = ::File.join(node['opsworks_java']['tomcat']['catalina_base_dir'], 'Catalina', 'localhost')
default['opsworks_java']['tomcat']['mysql_connector_jar'] = 'mysql-connector-java.jar'
default['opsworks_java']['tomcat']['apache_tomcat_bind_mod'] = 'proxy_http' # or: 'proxy_ajp'
default['opsworks_java']['tomcat']['apache_tomcat_bind_path'] = '/'
default['opsworks_java']['tomcat']['webapps_dir_entries_to_delete'] = %w(config log public tmp)
case node[:platform_family]
when 'debian'
  default['opsworks_java']['tomcat']['user'] = "tomcat#{node['opsworks_java']['tomcat']['base_version']}"
  default['opsworks_java']['tomcat']['group'] = "tomcat#{node['opsworks_java']['tomcat']['base_version']}"
  default['opsworks_java']['tomcat']['system_env_dir'] = '/etc/default'
when 'rhel'
  default['opsworks_java']['tomcat']['user'] = 'tomcat'
  default['opsworks_java']['tomcat']['group'] = 'tomcat'
  default['opsworks_java']['tomcat']['system_env_dir'] = '/etc/sysconfig'
end

include_attribute "opsworks_java::customize"

