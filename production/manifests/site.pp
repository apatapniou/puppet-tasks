node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
}

node 'webcentos.epam.com' {
class { 'webserver': }

}

node 'webubuntu.epam.com' {
class { 'webserver': }
include '::mysql::server'
  mysql::db { 'test_mdb':
    user     => 'test_user',
    password => 'mypass',
    host     => 'localhost',
    grant    => ['SELECT', 'UPDATE'],
  }
}

