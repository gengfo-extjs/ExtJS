development:
  adapter: mysql
  database: mywebapp_development
  host: localhost
  username: root
  password:

test:
  adapter: mysql
  database: mywebapp_test
  host: localhost
  username: root
  password:

production:
  adapter: mysql
  database: mywebapp
  host: localhost
  username: root
  password:
#---
use mywebapp_development;

DROP TABLE IF EXISTS `people`;
CREATE TABLE `people` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255),
  `email` VARCHAR(255),
  PRIMARY KEY (id)
) ENGINE=InnoDB;
#---
$ ./script/generate model Person
      exists  app/models/
      exists  test/unit/
      exists  test/fixtures/
      create  app/models/person.rb
      create  test/unit/person_test.rb
      create  test/fixtures/people.yml
#---
$ ./script/runner 'Person.create(:name => "John Doe", \
                                 :email => "john@doe.com")'
#---
$ ./script/generate controller people list
      exists  app/controllers/
      exists  app/helpers/
      create  app/views/people
      exists  test/functional/
      create  app/controllers/people_controller.rb
      create  test/functional/people_controller_test.rb
      create  app/helpers/people_helper.rb
      create  app/views/people/list.rhtml
#---
<!-- list.rhtml -->
<ul>
<% Person.find(:all).each do |person| %>
  <li>Name: <%= person.name %>, Email: <%= person.email %></li>
<% end %>
</ul>
#---
Person.find(:all, :limit => 5, :order => 'name', 
            :conditions => 'email IS NOT NULL')
#---
