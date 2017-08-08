Requirements
--------------------------------------------------------------------------------
1. Install Vagrant <https://www.vagrantup.com/downloads.html>

1. Install VirtualBox and VirtualBox Extension Pack
   <https://www.virtualbox.org/wiki/Downloads>.

1. Add `vagrant` and `VBoxManage` to your PATH.
    - This is most likely already done by the installation binaries.
      It's added to the system path.
    - To test this, type these commands in a terminal:

            ~$ vagrant --version
            Vagrant 1.8.1
            ~$ VBoxManage --version
            5.0.14r105127

    - You may need to log out and back in for the path modifications to take
      effect.

Usage
--------------------------------------------------------------------------------
1. Clone this repository onto your computer somewhere.

        git clone https://github.com/valkyrierobotics/dev-environment.git

1. Go into the directory and build the VM.

        vagrant up

1. Some errors during the `vagrant up` process can be addressed by
   re-provisioning the vagrant box. This is useful if, for example, an
   `apt-get` invocation timed out and caused the provisioning process to abort.

        vagrant provision

1. Once build, reboot the VM so it starts the GUI properly.

        vagrant reload

1. You can then log in and open a terminal. The username and password are both
   `user`.

1. At this point, you should be able to see "299 Virtual Environment" in the
   list of VMs in VirtualBox. Go to the settings of "299 Virtual Environment"
   to customize options such as increasing video memory or number of CPUs.

1. Download the code.

        git clone https://github.com/valkyrierobotics/mass.git
        cd mass

1. Install Bazel using the Ubuntu binary installer method
   <https://docs.bazel.build/versions/master/install.html>.
   Note that although we are using Debian, the binary installer works.

1. Once connected to the robot's radio through wifi, ssh in to verify
   authenticity of the connection. Press ENTER for password.

        ssh admin@10.2.99.2

Building and Deploying To Robot
--------------------------------------------------------------------------------
1. After making any chances, build the code for the RoboRIO.

        bazel build //y2017/download_stripped --cpu=roborio -- $(cat NO_BUILD_ROBORIO)

1. Deploy code to RoboRIO.

        bazel run //y2017/download_stripped --cpu=roborio -- 10.2.99.2
