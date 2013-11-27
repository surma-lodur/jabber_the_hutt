
FactoryGirl.define do
  sequence :mac do |n|
    "68:a8:6d:28:51:0#{n}"
  end

  factory :arp_entry, :class => 'JabberTheHutt::SystemFetch::ArpEntry' do
    last_seen {DateTime.now}
    mac       {FactoryGirl.generate(:mac)} 
  end
end
