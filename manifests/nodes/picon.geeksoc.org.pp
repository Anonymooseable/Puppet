
node 'picon.geeksoc.org' {
    #$sshd_config_PermitRootLogin = 'no'
  
  # Modules
  include epylog
  include bind
  include gs-scripts::adduser
  include gs-scripts::listusers
  include gs-scripts::userdir-disable
  $syslog_server_local = true
  
    nfs::share { 'home':
        path    => '/home',
        allowed => '130.159.141.64/26',
        options => 'rw,sync,no_subtree_check',
    }

  # Nightly backup of /home
  cron { 'rSyncArgama':
    command =>
'/usr/bin/rsync -arv /home/ 130.159.141.117:/home/backup/home --delete',
    user    =>  root,
    hour    =>  3,
    minute  =>  30
  }
  
  # Nightly check to disable home dirs of expired accounts
  cron { 'userdir-disable':
    command =>  '/usr/local/sbin/userdir-disable',
    user    =>  root,
    hour    =>  4,
    minute  =>  30
  }

    # Sync ssh keys and create new home dirs every 5 mins (30 is usual)
    $syncGasOften = true

  # Message of the day
  file { '/etc/motd':
        content => "
______ _                        _____           _     _____            
| ___ (_)                      |  __ \         | |   /  ___|           
| |_/ /_  ___  ___  _ __       | |  \/ ___  ___| | __\ `--.  ___   ___ 
|  __/| |/ __|/ _ \| '_ \      | | __ / _ \/ _ \ |/ / `--. \/ _ \ / __|
| |   | | (__| (_) | | | |  _  | |_\ \  __/  __/   < /\__/ / (_) | (__ 
\_|   |_|\___|\___/|_| |_| (_)  \____/\___|\___|_|\_\\\____/ \___/ \___|

Primary Contact: GSAG - gsag@geeksoc.org
Purpose: NFS, LDAP, DNS Server & Puppet Master

This server is Puppet managed - local changes may be overwritten!
-------------------

Bringing your files to you - Because we can!

"
    }

  # Roles
  include global
}
