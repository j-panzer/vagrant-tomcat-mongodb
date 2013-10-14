node default {
   include base
}

class requirements {
  include sysconfig
  include sysconfig::sudoers
  include ssh::server

  group { "vagrant":
    ensure => 'present',
  }
  user { "vagrant":
    ensure  => 'present',
    gid     => 'vagrant',
    require => Group['vagrant']
  } -> file { "/home/vagrant":
    ensure => directory,
    owner  => vagrant
  }

  ssh::user { "vagrant": }

  # user and group puppet necessary for rvm
  group { "puppet":
    ensure => 'present',
  }
  user { "puppet":
    ensure  => 'present',
    gid     => 'puppet',
    require => Group['puppet']
  }
}

stage { 'requirementsstage': before => Stage['main'] }

class doinstall {

  package {"vim-enhanced":
    ensure => installed
  }

  include projects
  include java::jdk
  
  class { requirements: stage => 'requirementsstage' }

  Class['java::jdk'] -> Class['projects']
}

  # disable the firewall
  service {"iptables":
    ensure => stopped
  }
  
  service {"ip6tables":
    ensure => stopped
  }
# start and set up everything
include doinstall
