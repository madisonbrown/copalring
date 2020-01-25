<b>Copal Ring</b>

Copal Ring is a server cluster management tool which allows for rapid deployment of web applications and services. It is intended to provide an ideal runtime environment for applications written on the Copal Application Framework.

OVERVIEW

Copal Ring will install and configure a typical LAMP stack on each node, plus Galera Cluster for database syncrhonization and Git for filesystem synchronization.
Nodes are added to the cluster simply by running the installer on a new server and providing the IP address of an exisitng node as well as it's rsa key data.
Nodes can be removed from the cluster via the commandline of the target server.
Commands can be run on all servers automatically via the commandline of any single server in the cluster.
Applications and certain configuration changes can be deployed by pushing to automatically prepared git repositories on any single server in the cluster.

USE

Copal Ring must be installed on a fresh image of Ubuntu 18.04 as the root user.

<pre>
  #to build the debian packages from scratch:
  #starting in /root:
  apt update
  apt install devscripts
  apt install dh-make
  git clone https://github.com/madisonbrown/copalring
  cd copalring
  bash main.sh
  #
  #to install the debian package:
  cd deb
  dpkg -i copalring_1.0-1_all.deb
  #
  #to initialize a node
  copal init
  #
  #to view encoded rsa key data (for adding a node to an existing cluster)
  copal serial
  #to perform a task synchronously on all nodes:
  copal cycle "echo hostname"
  #
  #to remove a node
  copal sync remove 10.20.30.40
  #
  #to edit the apache configuration files:
  #from the development system:
  git clone ssh://10.20.30.40/etc/copal/config/.git
  git checkout stage
  #make changes
  git add .
  git commit -m "initial"
  git push
  #
  #to deploy an application:
  #from the development system:
  git clone ssh://10.20.30.40/var/www/.git
  git checkout stage
  #make changes
  git add .
  git commit -m "initial"
  git push
  </pre>
