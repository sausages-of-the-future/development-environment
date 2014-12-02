class devenv::nginx {

    package { 'nginx':
        ensure   => latest
    }

    exec { 'configure_nginx':
        command => '/vagrant/script/bin/dev-nginx-conf',
        require => Package['nginx'],
    }

    # find a better way of doing this
    exec { 'configure_hosts':
        command => '/vagrant/script/bin/dev-host-conf',
        require => Exec['configure_nginx']
    }

}
