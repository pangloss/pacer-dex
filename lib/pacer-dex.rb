require 'pacer' unless defined? Pacer

lib_path = File.expand_path(File.join(File.dirname(__FILE__), '../lib'))
$:.unshift lib_path unless $:.any? { |path| path == lib_path }

require 'pacer-dex/version'

if Pacer::Dex::ENABLED
  require Pacer::Dex::JAR

  require 'pacer-dex/graph'
else
  puts "Dex has been disabled."
  puts
  puts "Please ensure you are running a compatible JVM (see pacer-dex/version.rb)"
  puts "or set Pacer::Dex::ENABLED = true to force."
  puts
end
