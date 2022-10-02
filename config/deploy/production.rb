server '43.206.40.73', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/aono/.ssh/id_rsa'