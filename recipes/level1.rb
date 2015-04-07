include_recipe 'stripe-ctf::apache'

level1_root = File.join(node['stripe-ctf']['root'], '1')

directory level1_root do
  recursive true
end
directory File.join(level1_root, 'log')

template File.join(level1_root, 'level02-password.txt') do
  source "level02-password.txt.1.erb"
end

template File.join(level1_root, 'index.php') do
  source 'index.php.1.erb'
end

template File.join(level1_root, 'secret-combination.txt') do
  source 'secret-combination.txt.1.erb'
end

execute "htpasswd -bc passwords #{node['stripe-ctf']['level1']['password']} #{node['stripe-ctf']['user']}"

template '/etc/apache2/sites-available/level1.conf' do
  source 'apache.conf.erb'
  variables({
    :level => "1",
    :root => level1_root
  })
  notifies :restart, 'service[apache2]', :delayed
end

link '/etc/apache2/sites-enabled/level1.conf' do
  to '/etc/apache2/sites-available/level1.conf'
  notifies :restart, 'service[apache2]', :delayed
end
