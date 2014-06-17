set :stage, :production

server 'yartrans.ua', user: 'yartranscom', roles: %w{web app db},
  ssh_options: {
    # keys: %w(/home/user_name/.ssh/id_rsa),
    forward_agent: false,
    auth_methods: %w(password),
    password: 'YaRtRaN8*pa88w0rd*c0M'
  }

fetch(:default_env).merge!(rails_env: :production)