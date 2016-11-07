#
# Cookbook Name:: my-first-cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node['mycookbook']['packages'].each do |pkg|
	package pkg do
	  action :install
	end
end

execute 'Install python package' do
  action :run
  command 'pip install flask'
  # not_if 'pip list | grep -i flask | wc -l'
end

template node['mycookbook']['apache']['conf_file'] do
  source 'AAR-apache.conf.erb'
  action :create
end

template node['mycookbook']['app']['config_file'] do
  source 'AAR_config.py.erb'
  action :create
  notifies :restart, 'service[apache2]', :immediately
end

service 'apache2' do
  action [:start, :enable]
end

cookbook_file node['mycookbook']['app']['db_creation_script'] do
  action :create
  notifies :run, 'execute[Run mysql script]', :immediately
  notifies :run, 'execute[Create mysql user]', :immediately
  notifies :run, 'execute[Grant mysql user permissions]', :immediately
end

execute 'Run mysql script' do
  command "mysql -p#{node['mycookbook']['app']['mysql_pass']} < #{node['mycookbook']['app']['db_creation_script']}"
  action :nothing
end

execute 'Create mysql user' do
  command "mysql -p#{node['mycookbook']['app']['mysql_pass']} -e \"CREATE USER \'#{node['mycookbook']['app']['db_user']}\'@\'#{node['mycookbook']['app']['db_host']}\' IDENTIFIED BY \'#{node['mycookbook']['app']['db_pass']}\'\""
  action :nothing
end

execute 'Grant mysql user permissions' do
  command "mysql -p#{node['mycookbook']['app']['mysql_pass']} -e 'GRANT CREATE,INSERT,DELETE,UPDATE,SELECT on #{node['mycookbook']['app']['db_name']}.* to #{node['mycookbook']['app']['db_user']}@#{node['mycookbook']['app']['db_host']}'"
  action :nothing
end

# cookbook_file '/tmp/make_AARdb.sql' do
  # action :delete
# end
