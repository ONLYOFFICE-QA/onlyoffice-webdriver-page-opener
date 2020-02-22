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

def create_loader(loader_name)
  droplet = DropletKit::Droplet.new(name: loader_name,
                                    region: DROPLET_REGION,
                                    image: DROPLET_IMAGE,
                                    size: DROPLET_SIZE,
                                    ssh_keys: [SSH_KEY_ID])
  do_api.client.droplets.create(droplet)
  do_api.wait_until_droplet_have_status(loader_name)
  do_api.get_droplet_ip_by_name(loader_name)
end

def create_new_loader_and_info
  next_loader = next_loader_name
  ip = create_loader(next_loader)
  puts('Server created, waiting for ssh to boot-up')
  sleep(30)
  puts("To access `#{next_loader}` "\
       "run `ssh -o StrictHostKeyChecking=no root@#{ip}`")
  ip
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
  create_new_loader_and_info
end

task 'Create one more loader and run tests'
task :create_loader_and_run_tests, :container_count do |_t, args|
  args.with_defaults(container_count: 30)
  loader_ip = create_new_loader_and_info
  run_command = 'docker run -itd '\
                "-e URL='#{ENV['WEBDRIVER_PAGE_OPENER_DS_URL']}' "\
                "-e S3_KEY='#{ENV['WEBDRIVER_PAGE_OPENER_S3_KEY']}' "\
                '-e S3_PRIVATE_KEY='\
                "'#{ENV['WEBDRIVER_PAGE_OPENER_S3_PRIVATE_KEY']}' "\
                'shockwavenn/onlyoffice-webdriver-page-opener;'
  args[:continer_count].times do |_|
    `ssh -o StrictHostKeyChecking=no root@#{loader_ip} "#{run_command}"`
    puts('Run one container')
    sleep(5) # Timeout between commands to not be banned by ssh
  end
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
