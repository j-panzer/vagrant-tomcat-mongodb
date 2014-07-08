vagrant-tomcat-mongodb-box
===============
A vagrant box to develop with Java, Tomcat and MongoDB.

* Modify Tomcat user and password in tomcat-users.xml.erb.
* Generate the environment with: 
** vagrant up
** vagrant provision
* loacal access:
** vagrant ssh
* remote access:
** ssh -p <port> vagrant@<ip-add>
** <port> in Vagrantfile
*** config.vm.forward_port 22, 2224, :auto => true
** <ip-add> of the machine running the environment
