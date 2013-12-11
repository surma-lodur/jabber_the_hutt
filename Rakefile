
$LOAD_PATH << "."

require 'jabber_the_hutt'
require 'irb'

desc 'starts an irb'
task :console do
  ARGV.clear
  IRB.start
end

task :c => :console


namespace :export do
  desc 'generates a visitors.json into tmp/, mat_daemon must watch eth device!'
  task :json do
    File.open('tmp/visitors.json', 'w').write(
      JabberTheHutt::Visitors.get_identities.to_json
    )
  end
end
