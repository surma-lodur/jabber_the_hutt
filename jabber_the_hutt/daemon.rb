
module JabberTheHutt::Daemon 
  class << self

    def refetch_timer
      EventMachine::Timer.new(10) do
        puts "[#{DateTime.now.to_s}] Refetch"
        JabberTheHutt::SystemFetch::refresh_arps
        JabberTheHutt::Daemon.refetch_timer
      end
    end # .refetch_timer
  end # class << self
end
