VAGRANTFILE_API_VERSION = "2"
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    ### global configs
    config.ssh.insert_key = false # important

    # VM cups
    config.vm.define :"cups" do |host|
      host.vm.box = "generic/debian10"
      host.vm.network :private_network,
        :ip => "192.168.7.201",
        :libvirt__network_name => "proaluno",
        :libvirt__forward_mode => "nat"
      host.vm.provider :libvirt do |v|
        v.memory = 1024
        v.cpus = 1
      end
    end

    # VM samba
    config.vm.define :"samba" do |host|
      host.vm.box = "generic/debian10"
      host.vm.network :private_network,
        :ip => "192.168.7.202",
        :libvirt__network_name => "proaluno",
        :libvirt__forward_mode => "nat"
      host.vm.provider :libvirt do |v|
        v.memory = 1024
        v.cpus = 1
      end
    end

    # VM laravel
    config.vm.define :"laravel" do |host|
      host.vm.box = "generic/debian10"
      host.vm.network :private_network,
        :ip => "192.168.7.203",
        :libvirt__network_name => "proaluno",
        :libvirt__forward_mode => "nat"
      host.vm.provider :libvirt do |v|
        v.memory = 1024
        v.cpus = 1
      end
    end

    # VM terminal
    config.vm.define :"terminal" do |host|
      host.vm.box = "generic/debian10"
      host.vm.network :private_network,
        :ip => "192.168.7.204",
        :libvirt__network_name => "proaluno",
        :libvirt__forward_mode => "nat"
      host.vm.provider :libvirt do |v|
        v.memory = 2048
        v.cpus = 2
      end
    end

end
