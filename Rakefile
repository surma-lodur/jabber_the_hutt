
$LOAD_PATH << "."

require 'jabber_the_hutt'
require 'irb'

desc 'starts an irb'
task :console do
  ARGV.clear
  IRB.start
end

task :c => :console

task :test_server do
  require 'webrick'

  dir = File.dirname(__FILE__)
  root = File.expand_path(File.join(dir, 'tmp'))

  server = WEBrick::HTTPServer.new(
  	:BindAddress => 'localhost',
  	:Port => 13337,
  	:DocumentRoot => root
  )

  server.mount "/", WEBrick::HTTPServlet::FileHandler, dir

  server.start
end

task :all_in_one do
  require File.expand_path('../jabber_the_hutt', __FILE__)

  EM.run do
    EM.add_periodic_timer(10) do
      File.open('tmp/visitors.json', 'w') do |file|
        file << JabberTheHutt::Visitors.get_identities.to_json
      end

      system "scp tmp/visitors.json hacksaar-spaceboard:/data/visitors.json"
    end

    EM::Xmpp::Connection.start(
      JabberTheHutt.config.jabber[:jabber_id],
      JabberTheHutt.config.jabber[:password],
      JabberTheHutt::ChatBot
    )

    JabberTheHutt::Daemon.refetch_timer
  end
end

namespace :export do
  desc 'generates a visitors.json into tmp/, mat_daemon must watch eth device!'
  task :json do
    File.open('tmp/visitors.json', 'w') do |f|
      f.write(
        JabberTheHutt::Visitors.get_identities.to_json
      )
    end
  end
end
