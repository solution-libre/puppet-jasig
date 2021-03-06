# == Define Resource Type: cas::service
#
# This type will setup a service configuration file inside
#  the appropriate directory to allow the SSO for an app.
#
# === Parameters
#
# [*service_id*]
#   Required Ant pattern or regular expression describing a logical service. 
#    A logical service defines one or more URLs where a service or services 
#    are located. The definition of the url pattern must be done carefully 
#    because it can open security breaches.
#
# [*id*]
#   Required unique identifier.
#
# [*enabled*]
#   Flag to toggle whether the entry is active; a disabled entry produces 
#    behavior equivalent to a non-existent entry.
#
# [*sso_enabled*]
#   Set to false to force users to authenticate to the service regardless 
#    of protocol flags (e.g. renew=true). This flag provides some support 
#    for centralized application of security policy.
#
# === Examples
#
#  Adding a service:
#
#  cas::service { 'Jenkins':
#    service_id   => '^https://ksf.echoes.fr.+jenkins.+',
#    name         => 'jenkins.json',
#    id           => '100',
#    $enabled     => true,
#    $sso_enabled => true,
#  }
#
# === Authors
#
# Thomas Saquet <thomas@echoes.fr>
#
define cas::service (
  $service_id  = undef,
  $id          = undef,
  $enabled     = true,
  $sso_enabled = true,
) {

  include cas::params

  file { "${title}.json":
      ensure  => 'present',
      path    => "${$cas::params::service_directory}/${title}.json",
      mode    => '0644',
      content => template('cas/service.erb'),
  }
}
