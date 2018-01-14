# Vagrantfile API/syntax version. Don't touch unless you know what you're
# doing!
VAGRANTFILE_API_VERSION = "2"

# Install the necessary plugins.
required_plugins = %w( vagrant-persistent-storage )
required_plugins.each do |plugin|
  unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin' then
    exec "vagrant plugin install #{plugin};vagrant #{ARGV.join(" ")}"
  end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "debian/jessie64"

  config.vm.provider "virtualbox" do |vb|
    # Don't boot with headless mode
    vb.gui = true
    vb.name = "299 Virtual Environment"

    # There are two shortcuts for modifying number of CPUs and amount of
    # memory. Modify them to your liking.
    vb.cpus = 2
    vb.memory = 1024 * 2
  end

  # Use rsync to sync the /vagrant folder.
  # NOTE: If you change these settings they will not take effect until you
  # reboot the VM -- i.e. run a "vagrant reload".
  config.vm.synced_folder ".", "/vagrant", type: "rsync",
      rsync__exclude: [".git/", ".svn/", "workspace.vdi"], rsync__verbose: true

  # Set up apt and install packages necessary for building the code.
  config.vm.provision :shell, inline: "/vagrant/setup_apt.sh"
  config.vm.provision :shell, inline: "/vagrant/setup_extra_storage.sh"
  config.vm.provision :shell, inline: "/vagrant/setup_code_building.sh"
  config.vm.provision :shell, inline: "/vagrant/setup_desktop.sh"
  config.vm.provision :shell, inline: "/vagrant/setup_misc_packages.sh"
  config.vm.provision :shell, inline: "/vagrant/setup_vbox_guest_additions.sh"

  # Add a second disk so we have plenty of space to compile the code.
  config.persistent_storage.enabled = true
  config.persistent_storage.location = "workspace.vdi"
  config.persistent_storage.size = 40000 # MiB
  config.persistent_storage.use_lvm = false
  config.persistent_storage.filesystem = 'ext4'
  config.persistent_storage.mountpoint = '/home/user'

  # Forward the scouting app's port.
  config.vm.network :forwarded_port, guest: 5000, host: 5000, auto_correct: true
end
