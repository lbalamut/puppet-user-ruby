Ruby & Gems installation per user
=================================

Puppet module which can be used for per user instalation of

RVM and Ruby
------------
e.g:

    $user_name = "some_user"

    user_ruby::install_for { $user_name:
        ruby_version   => 'ruby-1.9.3-p194',
        rvm_version    => 'latest'
    }


Ruby gems
---------

    $user_name = "some_user"

    user_ruby::gem_for { [
             "$user_name:rake",
             "$user_name:http",
             "$user_name:net-ssh",
             "$user_name:aws-sdk",
             "$user_name:json_pure",
             "$user_name:sinatra",
         ]:

        ruby_version   => 'ruby-1.9.3-p194'
    }
