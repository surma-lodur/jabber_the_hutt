require 'hashie'
require 'active_record'

module JabberTheHutt::Config

  class << self
    def parse
      self.init_database

      return Hashie::Mash.new(
        symbolize_config( parse_yaml )
      )
    end

    protected

    def init_database
      ActiveRecord::Base.establish_connection(
        :adapter  => "sqlite3",
        :database => File.join(JabberTheHutt.root,"tmp/database")
      )

      begin
        ActiveRecord::Base.connection.create_table :arp_entries do |t|
          t.string   :mac
          t.datetime :last_seen
          t.datetime :seen_since
        end
      rescue Exception => e
      end
    end

    def parse_yaml
      YAML.load_file(
        File.expand_path('../../config/base.yml', __FILE__)
      )
    end # .parse_yaml


    def symbolize_config(hash)
      return hash unless hash.is_a?(Hash)

      result = {}

      hash.each do |key, value|
        result[key.to_sym] = symbolize_config(value)
      end

      return result
    end # .symbolize_config
  end # class << self
end
