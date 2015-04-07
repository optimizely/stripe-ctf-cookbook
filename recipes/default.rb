#
# Cookbook Name:: stripe-ctf
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node['stripe-ctf']['levels'].each do |level|
  include_recipe "stripe-ctf::level#{level}"
end
