# == Class: icinga2::service
#
# This class handles the Icinga 2 service. By default the service will start on boot and will be restarted if stopped.
#
# === Parameters
#
# This class does not provide any parameters.
# To control the behaviour of this class, have a look at the parameters:
# * icinga2::ensure
# * icinga2::enable
#
# === Examples
#
# This class is private and should not be called by others than this module.
#
#
class icinga2::service {

  if defined($caller_module_name) and $module_name != $caller_module_name {
    fail("icinga2::service is a private class of the module icinga2, you're not permitted to use it.")
  }

  $ensure         = $::icinga2::ensure
  $enable         = $::icinga2::enable
  $manage_service = $::icinga2::manage_service
  $service        = $::icinga2::params::service
  $reload         = $::icinga2::params::service_reload

  if $manage_service {
    service { $service:
      ensure     => $ensure,
      enable     => $enable,
      hasrestart => $reload ? {
        undef   => false,
        default => true,
      },
      restart    => $reload,
    }
  }

}
