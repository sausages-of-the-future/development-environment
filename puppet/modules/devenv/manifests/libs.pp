class devenv::libs {

  package { 'libcurl4-openssl-dev':
    ensure   => latest
  }

  package { 'binutils':
    ensure   => latest
  }

  package { 'libproj-dev':
    ensure   => latest
  }

  package { 'gdal-bin':
    ensure   => latest
  }

  package { 'libgdal-dev':
    ensure   => latest
  }

  package { 'libgeos-3.4.2':
    ensure   => latest
  }

  package { 'libproj0':
    ensure   => latest
  }

  package { 'libgdal1h':
    ensure   => latest
  }

  package { 'libevent-dev':
    ensure   => latest
  }

}
