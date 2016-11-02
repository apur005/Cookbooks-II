include_recipe 'opsworks_java::tomcat_install'
include_recipe 'opsworks_java::tomcat_service'

service 'tomcat' do
  action :enable
end

# for EBS-backed instances we rely on autofs
 bash '(re-)start autofs earlier' do
   user 'root'
     code <<-EOC
         service autofs restart
           EOC
             only_if { infrastructure_class?('ec2') }
               notifies :restart, 'service[tomcat]'
               end

               include_recipe 'opsworks_java::tomcat_container_config'
               include_recipe 'apache2'
               include_recipe 'opsworks_java::apache_tomcat_bind'
               [ec2-user@ip-172-31-3-28 recipes]$ cat tomcat_service.rb
               service 'tomcat' do
                 service_name node['opsworks_java']['tomcat']['service_name']

                   case node[:platform_family]
                     when 'debian'
                         supports :restart => true, :reload => false, :status => true
                           when 'rhel'
                               supports :restart => true, :reload => true, :status => true
                                 end

                                   action :nothing
                                   end
                                   
