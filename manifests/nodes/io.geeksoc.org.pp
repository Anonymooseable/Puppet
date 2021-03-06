
node 'io.geeksoc.org' {

    # Modules
    # include varnish
    # include nginx
    include haproxy
  
    # Disable varnish and nginx
    service { 'varnish':
        ensure    => stopped,
        enable    => false,
        hasstatus => true,
    }
    service { 'nginx':
        ensure    =>  stopped,
        enable    =>  false,
        hasstatus =>  true,
        restart   =>  '/usr/sbin/service nginx reload',
    }

    # Message of the day
    file { '/etc/motd':
        content => "
 _____             _____           _     _____            
|_   _|           |  __ \         | |   /  ___|           
  | |   ___       | |  \/ ___  ___| | __\ `--.  ___   ___ 
  | |  / _ \      | | __ / _ \/ _ \ |/ / `--. \/ _ \ / __|
 _| |_| (_) |  _  | |_\ \  __/  __/   < /\__/ / (_) | (__ 
 \___/ \___/  (_)  \____/\___|\___|_|\_\\\____/ \___/ \___|

Primary Contact: GSAG - gsag@geeksoc.org
Purpose: HAProxy reverse proxy

This server is Puppet managed - local changes may be overwritten!

"
    }
  
    # Roles
    include global
}
