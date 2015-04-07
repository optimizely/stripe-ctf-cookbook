include_recipe 'stripe-ctf::apache'

level2_root = File.join(node['stripe-ctf']['root'], '2')

directory level2_root do
  recursive true
end

directory File.join(level2_root, 'log')

directory File.join(level2_root, 'uploads') do
  owner 'www-data'
end

password_file = File.join(level2_root, 'password.txt')
template password_file do
  source "password.txt.2.erb"
  owner 'www-data'
  mode "0200"
end

cron_d 'remove_lev2_read' do
  minute  '*'
  command "chmod -r #{password_file}"
end

template File.join(level2_root, 'index.php') do
  source 'index.php.2.erb'
end

basic_auth_file = File.join(level2_root, 'passwords')
execute "htpasswd -bc #{basic_auth_file} #{node['stripe-ctf']['user']} #{node['stripe-ctf']['level2']['password']}" do
   not_if { ::File.exists?(basic_auth_file)}
end

template '/etc/apache2/sites-available/level2.conf' do
  source 'apache.conf.erb'
  variables({
    :level => "2",
    :root => level2_root
  })
  notifies :restart, 'service[apache2]', :delayed
end

link '/etc/apache2/sites-enabled/level2.conf' do
  to '/etc/apache2/sites-available/level2.conf'
  notifies :restart, 'service[apache2]', :delayed
end
