#
# Cookbook Name:: network
# Recipe:: default
#

Chef::Log.info("Try to include: #{node[:network][:fallback_cookbook]}::#{node[:network][:fallback_prefix]}#{node[:fqdn]}")

begin
  Chef::Log.info("Try to include: #{node[:network][:fallback_cookbook]}::#{node[:network][:fallback_prefix]}#{node[:fqdn]}")
  include_recipe "#{node[:network][:fallback_cookbook]}::#{node[:network][:fallback_prefix]}#{node[:fqdn]}"
rescue
  Chef::Log.info("Include failed: #{node[:network][:fallback_cookbook]}::#{node[:network][:fallback_prefix]}#{node[:fqdn]}")
end

include_recipe "network::autogen" if node["netconf"]
