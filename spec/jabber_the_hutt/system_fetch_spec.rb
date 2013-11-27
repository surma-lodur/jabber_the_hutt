require 'spec_helper'


describe JabberTheHutt::SystemFetch do
  let(:testinpit) do
    "Interface: eth0, datalink type: EN10MB (Ethernet)
  Starting arp-scan 1.8.1 with 256 hosts (http://www.nta-monitor.com/tools/arp-scan/)
  192.168.178.1  \tzz:xx:xx:aa:gg:ww\t(Unknown)
  192.168.178.2  \tzz:xx:xx:aa:gg:ww\tCIMSYS Inc
  192.168.178.62 \tzz:xx:xx:aa:gg:ww\tIntel Corporate
  192.168.178.32 \tzz:xx:xx:aa:gg:ww\t(Unknown)
  192.168.178.35 \tzz:xx:xx:aa:gg:ww\t(Unknown)
  192.168.178.22 \tzz:xx:xx:aa:gg:ww\t(Unknown)
  192.168.178.105\tzz:xx:xx:aa:gg:ww\tSamsung Electro Mechanics
  192.168.178.222\tzz:xx:xx:aa:gg:ww\tREALTEK SEMICONDUCTOR CORP.

  8 packets received by filter, 0 packets dropped by kernel
  Ending arp-scan 1.8.1: 256 hosts scanned in 1.365 seconds (187.55 hosts/sec). 8 responded"
  end


  describe '.get_arp' do
    before do
      JabberTheHutt::SystemFetch.stub(:call_arp_scan).and_return(testinpit)
    end
    it 'should split correctly' do
pp      JabberTheHutt::SystemFetch.get_arp

    end
  end # .get_arp
end
