stripe-ctf Cookbook
===================
cookbook for https://github.com/stripe-ctf/stripe-ctf-2.0

Requirements
------------
`bundle install`

Setup
-----------
The levels aren't 100% setup via the chef run. Often you'll have to start the server:

0: Not complete

1: May have to `sudo service apache2 restart`

2: Same as 1

3: `python /opt/stripe-ctf/3/secretvault.py`

4: `ruby /opt/stripe-ctf/4/srv.rb`

5: `ruby /opt/stripe-ctf/5/srv.rb`

6: `ruby /opt/stripe-ctf/6/srv.rb`

7: `python /opt/stripe-ctf/7/wafflecopter.py`

8: Not complete

All level run on port 300x, where 'x' is the level number

Running `kitchen converge` will create a vagrant at `.kitchen/kitchen-vagrant/default-ubuntu-1404/`. Ports are forwarded to localhost

TODO
-----------
- Implement levels 0 and 8
- Add auth to level 7
- Add level 7 client recipe
- Fix karma_fountain for level 6 (cannot find form)

License and Authors
-------------------
Authors: Mike Wood: michael.wood@optimizely.com
