# frozen_string_literal: true

require 'bundler/setup'
require 'onlyoffice_digitalocean_wrapper'

# @return [String] pattern for naming loaders
LOADER_PATTERN = 'lobashov-load'
SSH_KEY_ID = 12_886_810
DROPLET_SIZE = 's-32vcpu-192gb'
DROPLET_REGION = 'nyc3'
DROPLET_IMAGE = 'docker-18-04'

# @return [OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper]
#   api of DigitalOcean
def do_api
  @do_api ||= OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper.new
end

# @return [Array<String>] names of currently run loaders
def loaders_names
  loaders = []
  all_droplets = do_api.client.droplets.all
  all_droplets.each do |droplet|
    loaders << droplet.name if droplet.name.start_with?(LOADER_PATTERN)
  end
  loaders
end

# @return [String] next name of loader
def next_loader_name
  loaders = loaders_names
  return "#{LOADER_PATTERN}-0" if loaders.empty?

  loaders_digits = loaders.map { |x| x[/\d+/].to_i }
  "#{LOADER_PATTERN}-#{loaders_digits.max + 1}"
end

desc 'Destroy all loaders'
task :destroy_all_loaders do
  loaders_names.each do |droplet|
    do_api.destroy_droplet_by_name(droplet)
  end
end

desc 'List all loaders'
task :list_all_loaders do
  pp(loaders_names)
end

desc 'Create one more loader'
task :create_one_more_loader do
  next_loader = next_loader_name
  droplet = DropletKit::Droplet.new(name: next_loader,
                                    region: DROPLET_REGION,
                                    image: DROPLET_IMAGE,
                                    size: DROPLET_SIZE,
                                    ssh_keys: [SSH_KEY_ID])
  do_api.client.droplets.create(droplet)
  do_api.wait_until_droplet_have_status(next_loader)
  ip_of_server = do_api.get_droplet_ip_by_name(next_loader)
  puts("To access `#{next_loader}` run `ssh root@#{ip_of_server}`")
end

desc 'Stop (and remove) all containers on all loaders'
task :stop_all do
  loaders = loaders_names
  loaders.flatten.each do |loader|
    ip_loader = do_api.get_droplet_ip_by_name(loader)
    `ssh root@#{ip_loader} 'docker stop $(docker ps -a -q)'`
    `ssh root@#{ip_loader} 'docker rm $(docker ps -a -q)'`
  end
end
