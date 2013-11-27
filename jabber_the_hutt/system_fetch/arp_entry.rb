
class JabberTheHutt::SystemFetch::ArpEntry < ActiveRecord::Base
  
  TimeOut = 5.minutes

  before_save :refresh

  scope :removables, lambda {
    where(
      "last_seen < ?", 
      DateTime.now - JabberTheHutt::SystemFetch::ArpEntry::TimeOut
  )
  }

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
      self.clean_up
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

    def clean_up
      self.removables.destroy_all
    end

    protected

    def add_mac(mac, attributes = {})
      self.create({
        :mac => mac
      })
    end # .add_mac

  end # class << self
end # JabberTheHutt::SystemFetch::ArpEntry
