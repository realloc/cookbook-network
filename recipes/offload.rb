#
# Cookbook Name:: network
# Recipe:: offload
#
# Sometimes we need to turn off offloading. For example on NAT64 relay servers.
#

package 'ethtool'

node["network"]["offload"]["disable"].each do |iface|
  bash "Disable offloading on #{iface}" do
    ignore_failure true
    code <<-EOH
    ethtool --offload #{iface} tso off
    ethtool --offload #{iface} ufo off
    ethtool --offload #{iface} gso off
    ethtool --offload #{iface} gro off
    ethtool --offload #{iface} lro off
    EOH
  end
end

node["network"]["offload"]["enable"].each do |iface|
  bash "Enable offloading on #{iface}" do
    ignore_failure true
    code <<-EOH
    ethtool --offload #{iface} tso on
    ethtool --offload #{iface} ufo on
    ethtool --offload #{iface} gso on
    ethtool --offload #{iface} gro on
    ethtool --offload #{iface} lro on
    EOH
  end
end
