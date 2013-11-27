require 'rubygems'
require 'bundler'
require 'jabber/bot'
require 'pp'
require 'yaml'


module JabberTheHutt
  autoload :SystemFetch, File.expand_path('../jabber_the_hutt/system_fetch', __FILE__)
  autoload :Visitors, File.expand_path('../jabber_the_hutt/visitors', __FILE__)


  Config = YAML.load_file(
    File.expand_path('../config/mapping.yml', __FILE__)
  )
end
