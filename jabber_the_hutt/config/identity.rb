class JabberTheHutt::Config::Identity < Hashie::Dash
  property :macs
  property :contacts
  property :name
  property :last_seen
  property :seen_since
  property :avatar

  cattr_accessor :macs

  class << self
    def setup(identity_hashes)
      identities = identity_hashes.map do |name, hash|
        self.new(hash.merge({'name' => name}))
      end

      JabberTheHutt::Config::Identity.macs ||= {}

      identities.each do |identity|
        identity['macs'].each do |mac|
          JabberTheHutt::Config::Identity.macs[mac] = identity
        end
      end

    end # .setup
  end # class << self
end
