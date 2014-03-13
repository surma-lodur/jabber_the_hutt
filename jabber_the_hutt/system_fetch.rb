module JabberTheHutt::SystemFetch
  OS = `uname`.strip
  PingCmd = (OS == "Darwin") ? "ping -t 1 %s &> /dev/null" : "ping -w 1 %s &> /dev/null"

  autoload :ArpEntry, File.expand_path('../system_fetch/arp_entry', __FILE__)

  def self.refresh_arps
    JabberTheHutt::SystemFetch::ArpEntry.handle_macs(
      self.get_arp
    )
  end

  def self.get_arp
    result = self.call_arp_scan.scan(/((?:[0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2})/).flatten

    JabberTheHutt::Config::Identity.hostnames.each do |hostname, mac|
      if system(PingCmd % hostname) then
        p [hostname, mac, :responded]
        result << mac
      end
    end

    return result.uniq
  end

  protected

  def self.call_arp_scan
    @interface ||= JabberTheHutt.config.sysfetch.interface
    `arp-scan --interval=10 --localnet --interface=#{@interface}`
  end
end
