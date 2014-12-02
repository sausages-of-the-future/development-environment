class base {

    exec { 'apt_get_update':
        command => '/usr/bin/apt-get update'
    }

    package {'language-pack-en':
        require => Exec['apt_get_update'],
    }

    exec { 'additional_config':
        command => '/vagrant/script/additional-config'
    }
}

include base
include devenv
