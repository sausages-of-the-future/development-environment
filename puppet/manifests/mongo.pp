class devenv::mongo {

    class {'::mongodb::globals':
          manage_package_repo => true
        }->
    class {'::mongodb::server':
        port    => 27017,
        verbose => true,
    }

    mongodb_database { betagov_registers:
        ensure   => present,
        tries    => 10,
        require  => Class['mongodb::server'],
    }
}

include devenv::mongo
