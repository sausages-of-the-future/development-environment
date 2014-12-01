class devenv::python {

  package { 'python-dev':
    ensure   => latest
  }

  package { 'python3.4-dev':
    ensure   => latest
  }

  package { 'python-pip':
    ensure   => latest
  }

  package { 'virtualenv':
    ensure   => latest,
    provider => pip
  }

  package { 'virtualenvwrapper':
    ensure   => latest,
    provider => pip
  }

  package { 'python-gdal':
    ensure   => latest
  }

}

include devenv::python

