group {'puppet': ensure => 'present'}

exec { "update-package-list":
  command => "/usr/bin/sudo /usr/bin/apt-get update",
}

package { 'mongodb':
  ensure => present,
}

service { 'mongodb':
  ensure  => running,
  require => Package['mongodb'],
}

exec { 'allow remote mongo connections':
  command => "/usr/bin/sudo sed -i 's/bind_ip = 127.0.0.1/bind_ip = 0.0.0.0/g' /etc/mongodb.conf",
  notify  => Service['mongodb'],
  onlyif  => '/bin/grep -qx  "bind_ip = 127.0.0.1" /etc/mongodb.conf',
}


class java_7 {

  package { "openjdk-7-jdk":
    ensure => installed,
    require => Exec["update-package-list"],
  }

}

class tomcat_6 {
  
  package { "tomcat6":
    ensure => installed,
    require => Package['openjdk-7-jdk'],
  }
 
  package { "tomcat6-admin":
    ensure => installed,
    require => Package['tomcat6'],
  }
 
  service { "tomcat6":
    ensure => running,
    require => Package['tomcat6'],
    subscribe => File["tomcat-users.xml"]
  }
 
  file { "tomcat-users.xml":
    owner => 'root',
    path => '/etc/tomcat6/tomcat-users.xml',
    require => Package['tomcat6'],
    notify => Service['tomcat6'],
    content => template('/vagrant/templates/tomcat-users.xml.erb')
  }
 
}
 
# set variables
$tomcat_password = 'adminadmin'
$tomcat_user = 'tomcat'
 

include java_7
include tomcat_6

