class devenv::base {

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

include devenv::base
import 'libs.pp'
import 'tools.pp'
import 'python.pp'
import 'ruby.pp'
import 'mongo.pp'
import 'nginx.pp'
import 'postgres.pp'
