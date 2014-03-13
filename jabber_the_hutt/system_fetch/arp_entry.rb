
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
    self.seen_since = self.last_seen if self.seen_since.nil?
  end


  class << self

    ## 
    # macs: Array
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
      prev_entry = self.find_by_mac(mac)
      prev_entry.refresh

      if prev_entry.last_seen + TimeOut < DateTime.now then
        prev_entry.seen_since = prev_entry.last_seen
      end

      prev_entry.save!
    end # .refresh

    def macs
      self.all.map(&:mac)
    end

    def clean_up
      self.removables.destroy_all
    end

    protected

    def add_mac(mac, attributes = {})
      self.create!({
        :mac => mac,
      })
    end # .add_mac

  end # class << self
end # JabberTheHutt::SystemFetch::ArpEntry
