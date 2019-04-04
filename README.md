
# Reloaded

What is Reloaded?

Reloaded is a portal that offers you a set of complex features such as Secure Messaging, Social Media, Web Mail,
Online Shop and Instant Chat .

Installation
------------

Here's how to install reloaded:

clone the repository

    git clone https://github.com/d4x337/reloaded.git

Make your bundle happy:

    bundle install

Run the database migration:

    bundle exec rake db:create
    
    bundle exec rake db:migrate

Then migrate your database if you did not run during installation generator:

    bundle exec rake db:migrate
    
Evaluate the secrets as passwords, keys, entropies    

And reboot your server:

    rails s

You should be up and running now!



The Author
----
Davide Gonnella is an Italian CyberSecurity Expert. Starts programming as  teenager in the 90s with Clipper and still codes in Ruby, Java, C#, C++ and JS. 
Founded hackers.it in 2003 and runs its community for 10 years, building a network of technical people and mastered applications and networks, developing both defensive and offensive skills. Unix Administrator and Technical couch for young guys and girls in his spare time.
When not on the computers loves going to the gym, relaxing painting, reading, listening music or watching Netflix with his loved ones. Also loves cats, travelling, good food, wines; appreciates positive, hilarious and loving people.

Contributing
------------

In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

Developers
------------

* by reporting [bugs](https://github.com/d4x337/reloaded/issues)
* by suggesting new features
* by refactoring code
* by resolving [issues](https://github.com/d4x337/reloaded/issues)
* by writing specifications
* by writing code (*no patch is too small*: fix typos, add comments, clean up inconsistent whitespace)


Non Developers
------------

* by correcting a language translations file. Currently quite all (except Italian and English) need a review
from a mother tongue who is also used to the internet jargon of its own country. Currently are supported Italian,
English, German, French, Dutch, Swedish, Chinese, Russian, Portoguese and Spanish.
* by adjusting the design and navigation for a better user experience.
* by translating the english or italian dictionary into a new language
* by writing documentation


Application Security Specialists
------------

* find security bugs for a web application
* fix bugs discovered and reported as issues
* propose security improvements to raise the current level.


DevOps
------------

Some operations are not yet fully automated due to lack of time, resources and focus since the development
of features have been the main point in latest years. Any DevOp who would like to improve the system is encouraged
to do it: you will find a lot of sections to be automated and will be a big reason of satisfaction. 


Encryption Experts
------------

* apply a secrets management system, open like conjour or hishcorp solution.
* find ways to generate complex entropy, like hardware random prime numbers generators.
* review the javascript library code to generate private keys client side.


Project Roadmap
------------

* Finish RestAPI for machine-to-machine communications.
* Apply current design to the WebMail section. 
* New feature for the Social Network side
* Improvements to the Online Shop
* Web Chat using the current design


Technologies
------------
Without a lot of technologies this project wouldn't exist. So I am grateful for all the people and organizations
who worked building the dependencies of Reloaded. I may miss some but i'd to mention PostgreSQL, Ruby, Rails,
JQuery and many others.


Special Thanks
------------

Family, friends, colleagues and to some women that have been my inspiration and strength with their deep love.
I hope to have the change to return your priceless emotive support. Just some names to maintain their privacy, each
one have been very special to me in their own way, no competition or compares because you have been just awesome.
Thank you  Paola, Camilla, Frederique and Kim <3



Donating
--------

You can contribute also with Direct donations in order to improve and accelerate developments. Transfer to: 

NL48 ABNA 0459 2935 32
or
IT18E0760105138231481831485

Anonymous Bitcoin donations may be sent to: TBD 

Copyright (c) 2013-2019 Davide Gonnella, released under the [New BSD License](https://github.com/d4x337/reloaded/tree/master/LICENSE).