require '/usr/lib/ruby/gems/1.8/gems/sinatra-0.9.4/lib/sinatra'
 
Sinatra::Application.default_options.merge!(
  :run => false,
  :env => :production
)
 
require 'main'
run Sinatra.application
