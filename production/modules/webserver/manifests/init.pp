class webserver {
$path_html = '/var/www/html'
#$packagename = ''
#$vhosttemp = 'vhosts.conf.erb'

if $facts['osfamily'] == 'redhat' {
     $packagename = 'httpd'
     $confpath = '/etc/httpd/conf.d'
     package { $packagename : # Package Name
              ensure => installed, # Install the package
          }
}
elsif $facts['osfamily'] =~ /^(Debian|Ubuntu)$/ {
     $packagename = 'apache2'
     $confpath = '/etc/apache2/sites-available' 
     package { $packagename : # Package Name
              ensure => installed, # Install the package
          }
}

service { $packagename :
      ensure => running,
      enable => true,
      require => Package[$packagename]
    }
file { "${path_html}/index.html":
     ensure  => file,
     content => "Index HTML Is Managed By Puppet",
     mode    => '0644',
     notify  => Service[$packageName],
   }
file { "${confpath}/vhosts.conf":
      ensure    => file,
      content   => template('webserver/vhosts.conf.erb'),
    }
}
