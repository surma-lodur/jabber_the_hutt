module JabberTheHutt::Visitors

  def self.get
    (
    JabberTheHutt::SystemFetch.get_arp.map do |mac|
      self.macs[mac]
    end.uniq * "\n"
    ).strip
  end


  protected


  def self.macs
    {
      '68:a8:6d:28:51:4a' => 'Kevin Krieger',
      '8c:a9:82:4f:ae:ea' => 'Matthias Folz',
      'd8:b3:77:cd:42:ee' => 'Matthias Folz'      
    }

  end
end
