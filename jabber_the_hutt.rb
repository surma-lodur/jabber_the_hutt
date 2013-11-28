require 'rubygems'
require 'bundler'
require 'pp'
require 'yaml'


require 'eventmachine'
require 'em-xmpp/connection'
require 'em-xmpp/helpers'

module JabberTheHutt
  autoload :SystemFetch, File.expand_path('../jabber_the_hutt/system_fetch', __FILE__)
  autoload :Visitors,    File.expand_path('../jabber_the_hutt/visitors', __FILE__)
  autoload :Config,      File.expand_path('../jabber_the_hutt/config', __FILE__)
  autoload :ChatBot,     File.expand_path('../jabber_the_hutt/chat_bot', __FILE__)
  autoload :Daemon,      File.expand_path('../jabber_the_hutt/daemon', __FILE__)

  

  class << self
    def config
      @config ||= JabberTheHutt::Config.parse
      @config
    end # .config


    def root
      File.expand_path('..', __FILE__)
    end # .root
  end # class << self
end


JabberTheHutt.config
