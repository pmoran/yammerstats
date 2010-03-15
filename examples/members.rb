#!/usr/bin/env ruby

require 'rubygems'
require 'yammer4r'

yammer = Yammer::Client.new(:config => "oauth.yml")
users1 = yammer.users(:page => 1)
users2 = yammer.users(:page => 2)
all = users1 + users2
contacts = all.map {|u| "#{u.name} #{u.contact.email_addresses.first.address}"};
File.open("contacts.txt", "w") { |f| f.write(contacts.join("\n")) }
