class JabberTheHutt::Config::Identity < Hashie::Dash
  property :macs
  property :contacts
  property :name
  property :last_seen
  property :seen_since
  property :avatar
  property :hostnames

  cattr_accessor :macs
  cattr_accessor :hostnames

  def self.setup(identity_hashes)
    identities = identity_hashes.map do |name, hash|
      self.new(hash.merge({'name' => name}))
    end

    JabberTheHutt::Config::Identity.macs ||= {}
    JabberTheHutt::Config::Identity.hostnames ||= {}

    identities.each do |identity|
      identity['macs'].each do |mac|
        JabberTheHutt::Config::Identity.macs[mac] = identity
      end

      (identity['hostnames'] || {}).each do |hostname, mac|
        JabberTheHutt::Config::Identity.hostnames[hostname] = mac
      end
    end
  end

  def to_json()
    copy = self.to_hash
    copy.delete(:hostnames)
    copy.delete(:macs)
    return copy.to_json
  end
end
