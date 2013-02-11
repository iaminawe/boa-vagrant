# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "lucid32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, "192.168.10.88"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  config.vm.customize ["modifyvm", :id, "--memory", 1024]
  
    # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
 
# config.vm.share_folder "modules", "/data/all/o_custom_modules", "~/workspace/modules", :extra => "dmode=755,fmode=755,gid=0,uid=0", :nfs => true
# config.vm.share_folder "themes", "/data/all/o_custom_themes", "~/workspace/themes", :extra => "dmode=755,fmode=755,gid=0,uid=0", :nfs => true
# config.vm.share_folder "platforms-o1", "/data/disk/o1/static", "~/workspace/platforms", :extra => "dmode=777,fmode=777", :nfs => true
  
    config.vm.provision :chef_solo do |chef|
    # chef.data_bags_path = "data_bags"
    # chef.add_recipe "ssh_known_hosts"
    chef.add_recipe "barracuda"
  end

end
