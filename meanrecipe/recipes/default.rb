#
# Cookbook Name:: meanrecipe
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

apt_update 'all platforms' do
action :update
end

execute 'express' do
command 'sudo npm install express --save'
end

execute 'angular' do
command 'sudo npm install angular'
end


execute 'flask' do
command 'sudo pip install flask'
end


