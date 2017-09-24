# Con On Rails
[![Build Status](https://travis-ci.org/ConOnRails/ConOnRails.svg?branch=master)](https://travis-ci.org/ConOnRails/ConOnRails)
[![Code Climate](https://codeclimate.com/github/ConOnRails/ConOnRails.png)](https://codeclimate.com/github/ConOnRails/ConOnRails)

This is ConOnRails, an application for managing the operations of conventions of any size.

By "operations", we mean specifically the tracking of incidents and information as the convention is running. Some cons
consider this to be a "security" task. [CONVergence](http://convergence-con.org) -- the convention this was originally
developed for and modeled after -- has instead an "operations" department that handles both security issues, and
dealing with other incidents such as needing to notify the hotel of necessary clean-ups or repairs.

In addition, the system manages the inventory of radios, and the "duty board" for who is currently in charge not just
in operations, but in all the key departments operations might need to contact, such as Hotel, Parties, Consuite, etc.

ConOnRails is derived conceptually from ConInABox by Thomas Keeley, who acted as product manager. The current theme
is derived entirely from the designs of DeNae Leverentz, who acted as our user experience expert and project manager.
All coding to date has been done by Michael Scott Shappe.

Version 3.4.9.4, 'Blackberry Jam and Butter on Mixed Biscuits, with Bacon, Hashbrowns, Coffee, and 4 slices of Key Lime Pie' was is the version that was used for the 2015 CONVergence convention, July 4th weekend. There is currently an active development branch for revising the security structure at ms/new-permissions.

A note about testing: most of the tests are still under Minitest in the `test` folder; there are a handful of rspec tests, and one jasmine test, under the `spec` folder, but for hysterical raisins, the Minitest-based testing is the main focus of TDD. 

It is the long-term goal of this project to be useful to other conventions, but we recognize that, in order to do
that, lots of things that are currently hardwired for CONvergence will need to be made configurable. This is an ongoing
effort. For more information, please see our document on [Contributing](https://github.com/ConOnRails/ConOnRails/blob/master/doc/CONTRIBUTING.md).

Michael Scott Shappe
<mshappe@camelopard-consulting.com>

PS. I ***still*** haven't pasted the right bits into the source files yet, but: Copyright &copy; 2011-2015 Thomas Keeley, DeNae
Leverentz and Michael Scott Shappe. Licensed under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).

## Docker Development

This project has been instrumented to use Docker for development purposes. If you don't have Docker installed, go to [the Docker website](http://www.docker.com) and click on the Get Docker menu item.

### Starting Out

From the project directory, follow these directions.

First, copy the `config/database.docker.yml` file to `config/database.yml`. This will give Docker the configuration it needs to talk to the databases.

Next, run `docker-compose up`. The first time you run this, it will build the ConOnRails application's Docker image. Future runs will not need to do this and will be much faster.

The third step is to prepare the database. Run these three commands in order:

```
docker-compose run web rake db:migrate
docker-compose run web rake db:seed
docker-compose run web sqlite3 -batch db/attendees.sqlite3 < db/attendees.seed
```

Now your database is ready to go, and the application will be usable [on localhost:3000](http://localhost:3000/).

### Getting Set Up for Testing

Of course, since this project is test-driven, you'll also need to get your tests going. This command will create the test database and, as a triggered action, run all of the tests:

```
docker-compose run web rake db:create test
```

After running this command once, though, you only need to run whichever tests you need to on a case-by-case basis. For example, you could do something like this:

```
docker-compose run web rake test test/unit/contact_test.rb
```

This will only run the specified test.

### Cleaning Up

When you're done developing for the moment, all you need to do is run `docker-compose stop`. This will shut down the Docker working environment, but it won't delete all of your data.

If you want to actually shut down *and destroy* your working environment, then run `docker-compose down`. If you do this, you'll have to follow all of the above instructions again.