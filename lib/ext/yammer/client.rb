module Yammer
  
  class Client
    
    def users(options = {})
      file = "examples/data/users.json"
      p ("Yammer::Client stubbed. Reading users from #{file}")
      s = IO.read(file)
      JSON.parse(s).map do |u|
        Yammer::User.new(mash(u), self)
      end  
    end
    
  end
  
end

