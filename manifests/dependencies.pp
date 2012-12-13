class user_ruby::dependencies() {

    define package_if_absent(
        $ensure = installed,
        $package_alias = undef) {

        if ! defined(Package[$name]) {
            package{ $name: ensure => $ensure, alias => $package_alias }
        }
    }

    case $::operatingsystem {
        Ubuntu,Debian: {
            package_if_absent { [
                             'build-essential',
                             'bison',
                             'openssl',
                             'libreadline6',
                             'libreadline6-dev',
                             'curl',
                             'git-core',
                             'zlib1g',
                             'zlib1g-dev',
                             'libssl-dev',
                             'libyaml-dev',
                             'libsqlite3-0',
                             'libsqlite3-dev',
                             'sqlite3',
                             'libxml2-dev',
                             'autoconf',
                             'libc6-dev',
                             'ruby-dev',
                             ]: }

            package_if_absent { 'libxslt1-dev':  alias => 'libxslt-dev' }
        }

        CentOS,RedHat: {
            case $::operatingsystemrelease {
                /^6\..*/: {
                    package_if_absent { 'libcurl-devel': }
                }
                default: {
                    package_if_absent { 'curl-devel': }
                }
            }
            package_if_absent { [
                             'which',
                             'gcc',
                             'gcc-c++',
                             'make',
                             'gettext-devel',
                             'expat-devel',
                             'zlib-devel',
                             'openssl-devel',
                             'perl',
                             'cpio',
                             'gettext-devel',
                             'wget',
                             'bzip2',
                             'sendmail',
                             'mailx',
                             'libxml2',
                             'libxml2-devel',
                             'libxslt',
                             'libxslt-devel',
                             'readline-devel',
                             'patch',
                             'git',
                             'ruby-devel',
                             'net-irc',
                             ]:  }
        }

        OracleLinux,RedHat: {
            package_if_absent { [
                             'which',
                             'gcc',
                             'gcc-c++',
                             'make',
                             'gettext-devel',
                             'expat-devel',
                             'libcurl-devel',
                             'zlib-devel',
                             'openssl-devel',
                             'perl',
                             'cpio',
                             'expat-devel',
                             'gettext-devel',
                             'wget',
                             'bzip2',
                             'sendmail',
                             'mailx',
                             'libxml2',
                             'libxml2-devel',
                             'libxslt',
                             'libxslt-devel',
                             'readline-devel',
                             'patch',
                             'git']: }
        }
    }
}
