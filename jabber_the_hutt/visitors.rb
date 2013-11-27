module JabberTheHutt::Visitors

  def self.get
    (
    JabberTheHutt::SystemFetch::ArpEntry.macs.map do |mac|
      self.macs[mac]
    end.uniq * "\n"
    ).strip
  end


  protected


  def self.macs
    JabberTheHutt.config.mac
  end
end
