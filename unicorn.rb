worker_processes 4

user "tamara", "tamara"

wd = Dir.pwd
$stderr.puts "Working directory: #{wd}"

working_directory wd

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen wd + "/run/.sock", :backlog => 64
listen 8088, :tcp_nopush => true

# nuke workers after 30 seconds instead of 60 seconds (the default)
# timeout 30

pid wd + "/run/unicorn.pid"
stderr_path wd + "/logs/unicorn.stderr.log"
stdout_path wd + "/logs/unicorn.stdout.log"


