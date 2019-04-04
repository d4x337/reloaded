
# Reloaded

What is Reloaded?

"Drop shipping is a supply chain management technique in which the retailer does not keep goods in stock, but instead transfers customer orders
and shipment details to either the manufacturer or a wholesaler, who then ships the goods directly to the customer." - [wikipedia](http://en.wikipedia.org/wiki/Drop_shipping)

So the main goal with spree_drop_ship is to link products to suppliers and forward orders to the appropriate suppliers.

Once an order is placed for a product that belongs to a supplier a shipment is created for the product's supplier.
This shipment is then sent to the supplier (via Email by default). The supplier then follows a link to the shipment
within the email where they are prompted to confirm the shipment.


.

Installation
------------

Here's how to install spree_drop_ship into your existing spree site AFTER you've installed Spree:

Add the following to your Gemfile:

    gem 'spree_drop_ship', github: 'spree-contrib/spree_drop_ship'

Make your bundle happy:

    bundle install

Now run the generator:

    rails g spree_drop_ship:install

Then migrate your database if you did not run during installation generator:

    bundle exec rake db:migrate

And reboot your server:

    rails s

You should be up and running now!

Sample Data
-----------

If you'd like to generate sample data, use the included rake tasks:

```shell
rake spree_sample:load               # Loads sample data into the store
rake spree_sample:suppliers          # Create sample suppliers and randomly link to products
rake spree_sample:drop_ship_orders   # Create sample drop ship orders
```

Demo
----

You can easily use the spec/dummy app as a demo of spree_drop_ship. Just `cd` to where you develop and run:

```shell
git clone git://github.com/spree-contrib/spree_drop_ship.git
cd spree_drop_ship
bundle install
bundle exec rake test_app
cd spec/dummy
rake db:migrate db:seed spree_sample:load spree_sample:suppliers spree_sample:drop_ship_orders
rails s
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

Todo
----

- Stock Items should automatically be set to backorderable false if the variant doesnt belong to the stock locations supplier.
- Must allow suppliers to edit their stock location addresses & require it.
- Return Authorization UI
- Better documentation
- related products should only allow suppliers own products to be related

The Code
----


The Author
----
Davide Gonnella is an Italian CyberSecurity Expert. Starts programming as  teenager in the 90s with Clipper and still codes in Ruby, Java, C#, C++ and JS. 
Founded hackers.it in 2003 and runs its community for 10 years, building a network of technical people and mastered applications and networks, developing both defensive and offensive skills. Unix Administrator and Technical couch for young guys and girls in his spare time.
When not on the computers loves going to the gym, relaxing painting, reading, listening music or watching Netflix with his loved ones. Also loves cats, travelling, good food, wines; appreciates positive, hilarious and loving people.

Contributing
------------

In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using prerelease versions
* by reporting [bugs](https://github.com/spree-contrib/spree_drop_ship/issues)
* by suggesting new features
* by [translating to a new language](https://github.com/spree-contrib/spree_drop_ship/tree/master/config/locales)
* by writing or editing documentation
* by writing specifications
* by writing code (*no patch is too small*: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues](https://github.com/spree-contrib/spree_drop_ship/issues)
* by reviewing patches

Donating
--------

Bitcoin donations may be sent to: 

Copyright (c) 2013-2019 Davide Gonnella, released under the [New BSD License](https://github.com/d4x337/reloaded/tree/master/LICENSE).