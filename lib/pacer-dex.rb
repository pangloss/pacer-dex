require 'pacer-dex/version'
if Pacer::Dex::ENABLED
  require 'pacer'
  require Pacer::Dex::JAR

  require 'pacer-dex/graph'
else
  puts "Dex has been disabled."
  puts
  puts "Please ensure you are running a compatible JVM (see pacer-dex/version.rb)"
  puts "or set Pacer::Dex::ENABLED = true to force."
  puts
end
