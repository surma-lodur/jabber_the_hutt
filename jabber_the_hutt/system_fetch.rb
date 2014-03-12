module JabberTheHutt::SystemFetch
  autoload :ArpEntry, File.expand_path('../system_fetch/arp_entry', __FILE__)

  def self.refresh_arps
    JabberTheHutt::SystemFetch::ArpEntry.handle_macs(
      self.get_arp
    )
  end

  def self.get_arp
    self.call_arp_scan.scan(/((?:[0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2})/).flatten
  end

  protected

  def self.call_arp_scan
    @interface ||= JabberTheHutt.config.sysfetch.interface
    `arp-scan --interval=10 --localnet --interface=#{@interface}`
  end
end
