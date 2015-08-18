require 'rake'
require File.expand_path('../config/environment', __FILE__)

desc "access the environment"
task :env do
  binding.pry
end

task :play do
  game = Game.new
  game.init_state
  game.start
end

