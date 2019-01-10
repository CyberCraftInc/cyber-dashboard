![alt text](https://s.dou.ua/CACHE/images/img/static/companies/CC-logo-gorizontal_gliGwd8/c2b2018adc57696d5abe1d7939bb3e79.png)
# Cyber-dashboard

1. [Description](#description)
2. [How to setup and run](#how-to-setup-and-run)
3. [How to run tests](#how-to-run-tests)
4. [Code climate](#code-climate)
5. [Test coverage](#test-coverage)
5. [License section](#license)
6. [Contribution section](#contribution)

#### Description
Cyber-dashboard is a web app for workers review. Everyone knows about each. You know what learn to next review and what you failed in the previous review, also reviewer know about your previous skills and result from your previous review

#### How to setup and run
To run this project you need
1. install Ruby version 2.5.1 and Rails version 5.2.2
2. install Node.JS version 6+
3. install PostgreSQL [official site](https://www.postgresql.org/download/)

4. install all gems `bundle install`
5. install yarn version 1.12.3
6. install all yarn packages `yarn`
7. migrate database `rake db:create db:migrate` for set default projects from [db/seed.rb](https://github.com/CyberCraftInc/cyber-dashboard/blob/master/db/seeds.rb/) add `db:seed` to previous command
 *instead of 4-7 you can run bin/setup* [bin/setup](https://github.com/CyberCraftInc/cyber-dashboard/blob/master/bin/setup) *! bin/setup not run seed.rb*
8. run project `foreman start`

#### How to run tests
This app using RSpec and Capybara. `bundle` install needed gems, but for working feature test you must install **geckodriver** for your browser. After this run all test `rake spec`


#### Test Coverage
This project had gem **simplecov** result about testing every time refresh location: **coverage/index.html** directory coverage in .gitignore and create after first running*

#### Code climate

The Code Climate workflow steps are:

1. Check if an app is works
2. Run tests. All examples must be without failures
3. Rubocop must return no offenses
4. All commits must be squashed to one
5. Do rebase. Then fix conflicts with (master).
6. Repeat step 2
7. Create pull request

#### License
© Copyright 2019

#### Contribution