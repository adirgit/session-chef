#
# Cookbook Name:: my-first-cookbook
# Recipe:: task1
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


directory '/opt/opsSchool' do
  action :create
  owner 'root'
  group 'root'
  mode '0755'
end

# cookbook_file '/opt/opsSchool/test-task1.txt' do
  # action :create
  # owner 'root'
  # group 'root'
# end

template '/opt/opsSchool/test-task1.txt' do
  source 'test-task1.erb'
  variables({
  :package_name => "unzip",
  :package_version => "6.0-9ubuntu1.5"
  })
  action :create
  owner 'root'
  group 'root'
end

package 'unzip' do
  version '6.0-9ubuntu1.5'
  action :install
end
