module JabberTheHutt::Visitors

  def self.get_names
    (
    JabberTheHutt::SystemFetch::ArpEntry.macs.map do |mac|
      JabberTheHutt::Config::Identity.macs[mac].name
    end.uniq * "\n"
    ).strip
  end # .get_names

  def self.get_identities
    identities = {}

    # TODO find maximum by multiple MAC per Identity
    JabberTheHutt::SystemFetch::ArpEntry.all.each do |arp_entry|
      identity = JabberTheHutt::Config::Identity.macs[arp_entry.mac]
      identities[identity.object_id] = identity.merge({
        :last_seen  => arp_entry.last_seen,
        :seen_since => arp_entry.seen_since
      })
    end

    return identities.values
  end # .get_identities

end
