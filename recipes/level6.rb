include_recipe 'phantomjs'
include_recipe 'casperjs'

package 'git'
package 'ruby-dev'
package 'sqlite3'
package 'libsqlite3-dev'

level6_root = File.join(node['stripe-ctf']['root'], '6')

git '/tmp/stripe/' do
  repository 'https://github.com/stripe-ctf/stripe-ctf-2.0'
end

execute "cp -R /tmp/stripe/levels/6 #{node['stripe-ctf']['root']}"

directory level6_root do
  user 'vagrant'
  mode 0755
end

template File.join(level6_root, 'srv.rb') do
  source 'srv.rb.6.erb'
end

level6_karma_root = File.join(level6_root, 'public_html')

directory level6_karma_root do
  owner 'vagrant'
end

template File.join(level6_karma_root, 'password.txt') do
  source 'password.txt.6.erb'
end

gem_package 'bundler'

execute 'bundle install' do
  cwd level6_root
  user 'vagrant'
end

cron_d 'level6_karma_bot' do
  minute  '*'
  command "casperjs #{File.join(level6_root, 'browser.coffee')} http://localhost:3006"
end

