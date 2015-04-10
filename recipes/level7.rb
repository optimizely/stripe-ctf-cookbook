package 'git'
package 'sqlite3'
package 'libsqlite3-dev'

include_recipe 'python'

python_pip 'flask'
python_pip 'py-bcrypt'
python_pip 'requests'

level7_root = File.join(node['stripe-ctf']['root'], '7')

git '/tmp/stripe/' do
  repository 'https://github.com/stripe-ctf/stripe-ctf-2.0'
end

execute "cp -R /tmp/stripe/levels/7 #{node['stripe-ctf']['root']}"

directory level7_root do
  user 'vagrant'
  mode 0755
end

template File.join(level7_root, 'wafflecopter.py') do
  source 'wafflecopter.py.erb'
end

execute "python initialize_db.py #{node['stripe-ctf']['level8']['password']}" do
  cwd level7_root
  user 'vagrant'
end
