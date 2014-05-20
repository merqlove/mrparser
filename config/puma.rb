root = "#{Dir.getwd}"

rackup "#{root}/config.ru"

environment "production"

daemonize false

bind "unix:///#{root}/tmp/puma/socket"
# bind 'tcp://0.0.0.0:4000'
pidfile "#{root}/tmp/puma/pid"
state_path "#{root}/tmp/puma/state"

threads 0, 16