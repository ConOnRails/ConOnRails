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

Version 3.5.2 'Lemon Curd and Scones', and will be the version that was used for the 2019 CONVergence convention, July 4th weekend. 
There is currently an active development branch for revising the security structure at ms/new-permissions. The main recent updates
have just been to keep dependencies current -- Ruby 2.5.5 and some Gem updates. This is about as far as can be gone without also
moving to Rails 5.2, which will be a bit of a project.

A note about testing: most of the tests are still under Minitest in the `test` folder; there are a handful of rspec tests, and one jasmine test, under the `spec` folder, but for hysterical raisins, the Minitest-based testing is the main focus of TDD. 

It is the long-term goal of this project to be useful to other conventions, but we recognize that, in order to do
that, lots of things that are currently hardwired for CONvergence will need to be made configurable. This is an ongoing
effort. For more information, please see our document on [Contributing](https://github.com/ConOnRails/ConOnRails/blob/master/doc/CONTRIBUTING.md).

Michael Scott Shappe
<mshappe@camelopard-consulting.com>

PS. I ***still*** haven't pasted the right bits into the source files yet, but: Copyright &copy; 2011-2019 Thomas Keeley, DeNae
Leverentz and Michael Scott Shappe. Licensed under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).
