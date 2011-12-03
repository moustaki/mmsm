require File.join(File.dirname(__FILE__), 'app')
require 'wurfl-lite-middleware'
use WURFL::Middleware
run Sinatra::Application
