include_recipe 'phantomjs'
include_recipe 'casperjs'

package 'git'
package 'ruby-dev'
package 'sqlite3'
package 'libsqlite3-dev'

level4_root = File.join(node['stripe-ctf']['root'], '4')

git '/tmp/stripe/' do
  repository 'https://github.com/stripe-ctf/stripe-ctf-2.0'
end

execute "cp -R /tmp/stripe/levels/4 #{node['stripe-ctf']['root']}"

directory level4_root do
  user 'vagrant'
  mode 0755
end

template File.join(level4_root, 'password.txt') do
  source 'password.txt.4.erb'
end

template File.join(level4_root, 'srv.rb') do
  source 'srv.rb.4.erb'
end

gem_package 'bundler'

execute 'bundle install' do
  cwd level4_root
  user 'vagrant'
end

execute 'ruby srv.rb &' do
  cwd level4_root
end

cron_d 'level4_karma_bot' do
  minute  '*'
  command "casperjs #{File.join(level4_root, 'browser.coffee')} http://localhost:3004"
end


