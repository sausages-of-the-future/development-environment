Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"

  config.ssh.forward_agent = true
  config.vm.network "private_network", :ip => "172.16.42.43"

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file  = "init.pp"
     puppet.module_path = "puppet/modules"
     puppet.options = "--verbose --debug"
  end


  config.vm.synced_folder ".aptget", "/var/cache/apt/archives/"

  config.vm.provider :virtualbox do |vb|
    vb.name = "gov-development"
    vb.customize ['modifyvm', :id, '--memory', ENV['VM_MEMORY'] || 4096]
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
    vb.customize ["modifyvm", :id, "--cpus", ENV['VM_CPUS'] || 4]
  end

  vagrantfile_extra = "#{ENV['VAGRANT_CWD']}/Vagrantfile_extra.rb"
  eval File.open(vagrantfile_extra).read if File.exists?(vagrantfile_extra)
end
