Vagrant::Config.run do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.forward_port 22, 2224, :auto => true
  config.vm.forward_port 80, 4567
  config.vm.forward_port 8080, 6789
  config.vm.network :hostonly, "33.33.13.38" 
 
#  config.vm.forward_port 27017, 27017 #mongodb

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path    = "puppet/modules"
    puppet.manifest_file  = "default.pp"
  end

end
