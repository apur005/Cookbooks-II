#
# Cookbook Name:: meanrecipe
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute



execute 'mongo db' do
command 'sudo apt-get -y install mongodb-server'
end

execute 'nodejs' do
command 'sudo apt-get -y install nodejs'
end


execute 'express' do
command 'sudo npm install express --save'
end

execute 'angular' do
command 'sudo npm install angular'
end

execute 'python' do
command 'sudo apt-get -y install python'
end

execute 'flask' do
command 'sudo pip install flask'
end


