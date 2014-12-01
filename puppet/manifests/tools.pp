class devenv::tools {
    package { 'git':
        ensure => latest
    }
}

include devenv::tools
