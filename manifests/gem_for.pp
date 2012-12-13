define user_ruby::gem_for(
  $ruby_version   = 'ruby-1.9.3-p194',
){

  $gem_user_array = split($name, ':')

  $user_name      = $gem_user_array[0]
  $gem_name       = $gem_user_array[1]

  $user_home      = "/home/${user_name}"
  $install_log    = "/home/${user_name}/.rvm/${ruby_version}_install.log"

  Exec {
    path        => [ "/home/${user_name}/.rvm/bin", '/usr/local/bin', '/usr/bin', '/bin' ],
    user        => "${user_name}",
    cwd         => "/home/${user_name}",
    environment => ["HOME=${user_home}"],
  }

  exec { "install_${gem_name}_for_${ruby_version}_for_${user_name}" :
    command     => "bash -l -c 'gem install --no-rdoc --no-ri ${gem_name} >> ${install_log}'",
    unless      => "bash -l -c 'gem list --local' | grep -c '${gem_name} '",
    require     => Exec["rvm_install_${ruby_version}_for_${user_name}"],
  }
}
