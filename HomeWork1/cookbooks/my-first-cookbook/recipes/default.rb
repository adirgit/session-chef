#
# Cookbook Name:: my-first-cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'libapache2-mod-wsgi' do
  action :install
end

package 'python-pip' do
  action :install
end

package 'python-mysqldb' do
  action :install
end

execute 'Install python package' do
  command 'pip install flask '
  action :run
end

# service 'apachectl' do
  # action [:stop]
# end

execute 'stop apachectl' do
  command 'sudo apachectl stop'
  action :run
end

template '/etc/apache2/sites-enabled/AAR-apache.conf' do
  source 'AAR-apache.conf.erb'
  action :create
end

template '/var/www/AAR/AAR_config.py' do
  source 'AAR_config.py.erb'
  action :create
end

cookbook_file '/tmp/make_AARdb.sql' do
  action :create
end

# execute 'Run mysql script' do
  # command 'mysql -proot < /tmp/make_AARdb.sql'
  # action :run
# end

cookbook_file '/tmp/make_AARdb.sql' do
  action :delete
end

execute 'Create mysql user' do
  command 'mysql -proot -e "CREATE USER \'aarapp\'@\'localhost\' IDENTIFIED BY \'7ERwzg7E\'"'
  action :run
end

execute 'Grant mysql user permissions' do
  command 'mysql -proot -e "GRANT CREATE,INSERT,DELETE,UPDATE,SELECT on AARdb.* to aarapp@localhost"'
  action :run
end

# service 'apachectl' do
  # action [:start, :enable]
# end

execute 'start apachectl' do
  command 'sudo apachectl start'
  action :run
end