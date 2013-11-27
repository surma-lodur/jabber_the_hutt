class JabberTheHutt::SystemFetch::ArpEntry
  attr_reader :time_out
  
  @entries

  def initialize(attributes = {})
    @attributes = attributes
    @time_out   = 1.minutes
  end


  class << self

    def register(mac)
      self.add_mac(mac)
    end

    def refresh(mac)
      @entries[mac]

    end # .refresh


    protected

    def add_mac=(mac, attributes = {})
      @entries ||= {}
      @entries[mac] = self.new({
        :mac => mac
      })
    end # .add_mac


  end # class << self
end # JabberTheHutt::SystemFetch::ArpEntry
