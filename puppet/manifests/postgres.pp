class devenv::postgres {

  class { 'postgresql::server':
    ip_mask_allow_all_users    => '0.0.0.0/0',
    listen_addresses           => '*',
  }

  class { 'postgresql::client': }
  class { 'postgresql::server::contrib': }
  class { 'postgresql::server::postgis': }

  postgresql::server::role { 'vagrant':
    superuser => true
  }

}

include devenv::postgres
