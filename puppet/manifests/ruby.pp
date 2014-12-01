class devenv::ruby {

  package { ['ruby', 'ruby-dev']:
    ensure   => latest
  }
  package { 'gcc':
    ensure   => latest
  }
  package { 'rubygems-integration':
    ensure   => latest
  }
  package { 'bundler':
    ensure   => latest,
    provider => gem
  }
  package { 'rake':
    ensure   => latest,
    provider => gem
  }
  package { 'sass':
    ensure   => latest,
    provider => gem
  }
  package { 'cucumber':
    ensure   => latest,
    provider => gem,
    require  => Package['gcc']
  }
  package { 'foreman':
    ensure   => latest,
    provider => gem
  }
}

include devenv::ruby

