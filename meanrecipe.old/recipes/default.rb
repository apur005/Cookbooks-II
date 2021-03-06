#
# Cookbook Name:: first_cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
execute 'update' do
command 'sudo apt-get -y update'
end

apt-package 'git' do
	action :install
end

apt-package 'ant' do
	action :install
end

execute 'oracle jdk' do
command ' wget http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u102-linux-x64.tar.gz'
end

bash_file  = '/etc/bash.bashrc/'

file bash_file do
  owner 'root'
  group 'root'
  mode '0755'
  content 'JAVA_HOME=/opt/java'
  content 'PATH=$PATH:/opt/java/bin:/opt/java/db/bin:/opt/java/jre/bin'
end

execute 'update alternatives' do
command 'update-alternatives --install "/usr/local/bin/java" "java" "/opt/java/jre/bin/java" 1'
end

execute 'default-java' do
command 'update-alternatives --set java /opt/java/jre/bin/java'
end

execute 'jdk-8u102-linux-x64.tar.gz' do
  command 'tar xzvf jdk-8u102-linux-x64.tar.gz'
  cwd '/opt/'
##  not_if { File.exists?("/file/contained/in/tar/here") }
end

execute 'rename folder' do
command '/opt/jdk1.8.0_102 /opt/java'
end


execute 'tomcat' do
command 'wget http://mirror.sdunix.com/apache/tomcat/tomcat-8/v8.0.23/bin/apache-tomcat-8.0.23.tar.gz'
end

directory '/opt/tomcat'
owner 'root'
group 'root'
mode '0775'
action :create	
end

execute 'untar tomcat' do
  command 'tar xzvf apache-tomcat-8.0.23.tar.gz --strip-components=1'
  cwd '/opt/tomcat/'
##  not_if { File.exists?("/file/contained/in/tar/here") }
end

bash 'tomcat configuration' do
code <<-EOH
chgrp -R tomcat /opt/tomcat/conf
chmod g+rwx /opt/tomcat/conf
chmod g+r /opt/tomcat/conf/*
chown -R tomcat /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/
EOH
end

template 'initconf' do
source 'tomcatconf.erb'
owner 'root'
group 'root'
mode '0755'
end

execute 'reload configuration' do
command 'initctl reload-configuration'
end

service 'tomcat' do
action :start
end

 

