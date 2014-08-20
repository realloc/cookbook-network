#
# Cookbook Name:: network
# Recipe:: autogen
#

Chef::Log.info("Cloning ifaces: #{node["netconf"]["ifaces"]}")

node["netconf"]["ifaces"].each do |iface|
  # We get list like ["eth0", {param=>value}]
  up = Array.new
  down = Array.new
  network_interfaces iface[0] do
    iface[1].each_key do |attr|
      if attr == 'target' && iface[1][attr].kind_of?(Array)
        send(attr, iface[1][attr].first)
        iface[1][attr].drop(1).each do |ext_addr|
          up << "ip addr add #{ext_addr} dev #{iface[0]}"
          down << "ip addr del #{ext_addr} dev #{iface[0]}"
        end
      elsif attr == 'up'
          up << iface[1][attr]
      elsif attr == 'down'
          down << iface[1][attr]
      else 
        send(attr, iface[1][attr])
      end
    end
    send("up", up)
    send("down", down)
  end
  up = nil
  down = nil
end
