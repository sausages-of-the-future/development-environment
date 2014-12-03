class devenv::redis {

  package { "redis-server":
    ensure => latest
  }

  package { "redis-tools":
    ensure => latest
  }

}
