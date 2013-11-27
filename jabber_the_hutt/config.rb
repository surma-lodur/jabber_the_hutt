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
        :database => File.join(JabberTheHutt.root,"database")
      )

      ActiveRecord::Base.connection.create_table :arp_entries, :force => true do |t|
        t.string   :mac
        t.datetime :last_seen
      end
    end

    def parse_yaml
      YAML.load_file(
        File.expand_path('../../config/mapping.yml', __FILE__)
      )
    end # .parse_yaml


    def symbolize_config(hash)
      hash.each do |key, value|
        if value.kind_of?(Hash)
          hash[key.to_sym] = {}
          value.each do |v_key, v_value|
            hash[key.to_sym][v_key.to_sym] = v_value
          end
        end
      end

      return hash
    end # .symbolize_config
  end # class << self
end
