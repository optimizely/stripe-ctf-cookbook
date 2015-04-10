package 'git'
package 'ruby-dev'
package 'sqlite3'
package 'libsqlite3-dev'

level5_root = File.join(node['stripe-ctf']['root'], '5')

git '/tmp/stripe/' do
  repository 'https://github.com/stripe-ctf/stripe-ctf-2.0'
end

execute "cp -R /tmp/stripe/levels/5 #{node['stripe-ctf']['root']}"

directory level5_root do
  user 'vagrant'
  mode 0755
end

template File.join(level5_root, 'password.txt') do
  source 'password.txt.5.erb'
end

template File.join(level5_root, 'srv.rb') do
  source 'srv.rb.5.erb'
end

gem_package 'bundler'

execute 'bundle install' do
  cwd level5_root
  user 'vagrant'
end

execute 'ruby srv.rb &' do
  cwd level5_root
end
