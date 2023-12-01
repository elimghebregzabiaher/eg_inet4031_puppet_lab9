package { 'apache2':
  ensure => installed,
}

package { 'php':
  ensure => installed,
  notify  => Service['apache2'],
  require => [Package['apache2']],
}

package { 'libapache2-mod-php':
  ensure => installed,
  require => Package['apache2'],
}

package { 'php-cli':
  ensure => installed,
  require => Package['libapache2-mod-php'],
}

package { 'php-mysql':
  ensure => installed,
  require => Package['php-cli'],
}

package { 'mariadb-server':
  ensure => installed,
  require => Service['apache2'],
}

file { '/var/www/html/phpinfo.php':
  source => '/home/elim/eg_inet4031_puppet_lab9/phpinfo.php',
  notify  => Service['apache2'],
  require => [Package['apache2']]
}

service { 'mariadb':
  ensure => running,
  enable => true,
  require => Package['mariadb-server'],
}

service { 'apache2':
  ensure => running,
  enable => true,
  require => [Package['apache2'], Package['php']]
}
