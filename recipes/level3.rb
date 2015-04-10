include_recipe 'python'

python_pip 'flask'
python_pip 'flup'

level3_root = File.join(node['stripe-ctf']['root'], '3')

directory level3_root do
  recursive true
end

secret_vault_file = File.join(level3_root, 'secretvault.py')
template secret_vault_file do
  source 'secretvault.py.erb'
end

template File.join(level3_root, 'generate_data.py') do
  source 'generate_data.py.erb'
end

template File.join(level3_root, 'index.html') do
  source 'index.html.3.erb'
end

