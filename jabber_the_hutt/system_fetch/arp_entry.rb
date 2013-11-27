
require 'active_record'
class JabberTheHutt::SystemFetch::ArpEntry < ActiveRecord::Base
  
  TimeOut = 5.minutes

  before_save :refresh

  def refresh
    self.last_seen  = DateTime.now
  end


  class << self


    def handle_macs(macs)
      macs.each do |mac|
        if exists?(:mac => mac)
          refresh(mac)
        else
          register(mac)
        end
      end
    end

    def register(mac)
      self.add_mac(mac)
    end

    def refresh(mac)
      self.find_by_mac(mac).save!
    end # .refresh

    def macs
      self.all.map(&:mac)
    end

    protected

    def add_mac(mac, attributes = {})
      self.create({
        :mac => mac
      })
    end # .add_mac


  end # class << self
end # JabberTheHutt::SystemFetch::ArpEntry
