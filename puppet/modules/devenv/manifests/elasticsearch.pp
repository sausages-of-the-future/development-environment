class devenv::elasticsearch {

  file  { 'elasticsearch apt repo':
    mode    => '0644',
    path    => '/etc/apt/sources.list.d/elasticsearch.list',
    content => 'deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main',
    require => Exec['elasticsearch key']
  }

  exec { 'elasticsearch key':
    command => "wget -qO - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -",
    path    => [ '/bin', '/usr/bin', '/usr/sbin' ]
  }

  exec { 'apt-get update':
    command => "/usr/bin/apt-get update",
    onlyif  => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
    require => File['elasticsearch apt repo']
  }

  package { 'elasticsearch':
    ensure  => latest,
    require => Exec['apt-get update']
  }

}
