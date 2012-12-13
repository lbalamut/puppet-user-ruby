define user_ruby::install_for(
    $user_name      = $title,
    $ruby_version   = 'ruby-1.9.3-p194',
    $rvm_version    = 'latest',
    ) {

    $install_log    = "/home/${user_name}/.rvm/${ruby_version}_install.log"
    $user_home      = "/home/${user_name}"

    Exec {
        path        => [ "/home/${user_name}/.rvm/bin", '/usr/local/bin', '/usr/bin', '/bin' ],
        user        => $user_name,
        cwd         => $user_home,
        environment => ["HOME=${user_home}"],
    }

    if ! defined(Class["User_ruby::Dependencies"]) {
        class { "user_ruby::dependencies": }
    }

    exec { "rvm_download_for_${user_name}" :
        command     => "bash -l -c 'wget https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer'",
        creates     => "${user_home}/rvm-installer",
    }

    file { "${user_home}/rvm-installer" :
        path        => "${user_home}/rvm-installer",
        mode        => 755,
        require     => Exec["rvm_download_for_${user_name}"],
    }

    exec { "rvm_setup_${user_name}" :
        command     => "bash -l -c '${user_home}/rvm-installer --version ${rvm_version} >> /home/${user_name}/.rvm.log'",
        creates     => "/home/${user_name}/.rvm/scripts/rvm",
        require     => [
            User[$user_name],
            File["${user_home}/rvm-installer"],
            Class["Build_box::Ruby::Dependencies"],
            ],
    }

    exec { "rvm_install_${ruby_version}_for_${user_name}" :
        command     => "bash -c -l 'rvm use ${ruby_version} --create --install --default >> ${install_log}'",
        creates     => "/home/${user_name}/.rvm/bin/${ruby_version}",
        require     => [ Exec["rvm_setup_${user_name}"] ],
    }
}
