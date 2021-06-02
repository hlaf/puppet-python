# == Class: python::params
#
# The python Module default configuration settings.
#
class python::params {
  $ensure                 = 'present'
  $version                = 'system'
  $pip                    = 'present'
  $dev                    = undef
  $virtualenv             = 'absent'
  $gunicorn               = 'absent'
  $manage_gunicorn        = true
  $provider               = undef
  $valid_versions = $::osfamily ? {
    'RedHat'  => ['3','27','33'],
    'Debian'  => ['3', '3.3', '2.7'],
    'Suse'    => [],
    'Gentoo'  => ['2.7', '3.3', '3.4', '3.5'],
    'Darwin'  => ['2.7'],
    'Windows' => ['2.7'],
  }

  if $::osfamily == 'RedHat' {
    if $::operatingsystem != 'Fedora' {
      $use_epel           = true
    } else {
      $use_epel           = false
    }
  } else {
    $use_epel             = false
  }

  $owner = $::operatingsystem ? {
    'windows' => undef,
    default   => 'root'
  }

  $group = $::operatingsystem ? {
    'Darwin'  => 'wheel',
    'windows' => 'Everyone',
    default   => 'root'
  }

  $gunicorn_package_name = $::osfamily ? {
    'RedHat' => 'python-gunicorn',
    default  => 'gunicorn',
  }

  if $::operatingsystem == 'windows' {
    $python_executable = 'python.exe'
  }

  $pip_provider = $::operatingsystem ? {
    'windows' => "${python_executable} -m pip",
    default   => 'pip',
  }

  $bin_dir = $::operatingsystem ? { 'windows' => 'Scripts', default => 'bin' }

  $rhscl_use_public_repository = true

}
