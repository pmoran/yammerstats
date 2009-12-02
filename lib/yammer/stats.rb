#!/usr/bin/env ruby

module Yammer

  class Stats

    def initialize(options = {})
      options.merge!(:config => "oauth.yml") unless options[:config]
      @yammer = Yammer::Client.new(options)
    end

    def top_updaters(options = {})
      users = @yammer.users(:sort_by => "messages", :reverse => false)
      if options.delete(:dump) == true
        users.each {|u| puts "#{u.name} - #{u.stats.updates}" }
      else
        template, output_file = options_or_defaults(options)
        output = ERB.new(IO.read(template), nil, '<>').result(binding)
        File.open(output_file, 'w') {|f| f.write(output)}      
      end
    end

    private
  
    def options_or_defaults(options)
      template = options.delete(:template) || 'examples/templates/top_updaters.erb'
      output_file = options.delete(:output) || 'top_updaters.xml'
      [template, output_file]
    end
  
  end

end
