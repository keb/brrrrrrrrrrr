################################################################################
#
# Vagrantfile
#
# Instructions
#
# 1. Install VirtualBox https://www.virtualbox.org/
# 2. Install Vagrant https://www.vagrantup.com/
# 3. Download this `Vagrantfile` to a folder
# 4. Modify VM_MEMORY and VM_CORES as is needed
# 5. Run `vagrant up` in that folder
# 6. Run `vagrant ssh` and follow the steps below
# 7. Follow instructions from README.md
#
# This is the default Vagrantfile provided by Buildroot (2023.11.1),
# with the following modifications
# - Update ubuntu/bionic64 (18.04) to ubuntu/jammy64 (22.04)
# - Increase VM_MEMORY and VM_CORES
# - Add libssl-dev to packages installed on provision
#
################################################################################

# Buildroot version to use
RELEASE='2023.11.1'

### Change here for more memory/cores ###
VM_MEMORY=8192
VM_CORES=4

Vagrant.configure('2') do |config|
	config.vm.box = 'ubuntu/jammy64'

	config.vm.provider :vmware_fusion do |v, override|
		v.vmx['memsize'] = VM_MEMORY
		v.vmx['numvcpus'] = VM_CORES
	end

	config.vm.provider :virtualbox do |v, override|
		v.memory = VM_MEMORY
		v.cpus = VM_CORES

		required_plugins = %w( vagrant-vbguest )
		required_plugins.each do |plugin|
		  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
		end
	end

	config.vm.provision 'shell' do |s|
		s.inline = 'echo Setting up machine name'

		config.vm.provider :vmware_fusion do |v, override|
			v.vmx['displayname'] = "Buildroot #{RELEASE} (Jammy)"
		end

		config.vm.provider :virtualbox do |v, override|
			v.name = "Buildroot #{RELEASE} (Jammy)"
		end
	end

	config.vm.provision 'shell', privileged: true, inline:
		"sed -i 's|deb http://us.archive.ubuntu.com/ubuntu/|deb mirror://mirrors.ubuntu.com/mirrors.txt|g' /etc/apt/sources.list
		dpkg --add-architecture i386
		apt-get -q update
		apt-get purge -q -y snapd lxcfs lxd ubuntu-core-launcher snap-confine
		apt-get -q -y install build-essential libncurses5-dev \
			git bzr cvs mercurial subversion libc6:i386 unzip bc libssl-dev
		apt-get -q -y autoremove
		apt-get -q -y clean
		update-locale LC_ALL=C"

	config.vm.provision 'shell', privileged: false, inline:
		"echo 'Downloading and extracting buildroot #{RELEASE}'
		wget -q -c http://buildroot.org/downloads/buildroot-#{RELEASE}.tar.gz
		tar axf buildroot-#{RELEASE}.tar.gz"

end
