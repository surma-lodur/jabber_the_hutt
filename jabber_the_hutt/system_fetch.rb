module JabberTheHutt::SystemFetch
  autoload :ArpEntry, File.expand_path('../system_fetch/arp_entry', __FILE__)

  def self.refresh_arps
    JabberTheHutt::SystemFetch::ArpEntry.handle_macs(
      self.get_arp
    )
  end

  def self.get_arp
    self.call_arp_scan.
      split("\n")[3..-4].map do |line|
      line.split("\t")[1]
      end
  end


  protected

  def self.call_arp_scan
    `arp-scan --localnet --interface=eth0`
  end
end
