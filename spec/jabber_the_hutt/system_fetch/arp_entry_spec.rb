require 'spec_helper'

describe JabberTheHutt::SystemFetch::ArpEntry do


  context 'class methods' do
    subject { JabberTheHutt::SystemFetch::ArpEntry }

    it 'should register a mac' do
      subject.register('ab:cd')
      subject.exists?(:mac => 'ab:cd').should be_true
      subject.find_by_mac('ab:cd').last_seen.should be_present
    end


    describe '.handle_macs' do
      it 'should call clean_up' do
        subject.should_receive(:clean_up)
        subject.handle_macs([])
      end
    end # .handle_macs


    describe '.clean_up' do
      let(:arp_entry) do
        FactoryGirl.create(:arp_entry)
      end

      before do
        arp_entry
      end

      it 'should not delete new entries' do
        subject.count.should be(1)
        Timecop.travel(DateTime.now + 1.minutes) do
          subject.clean_up
        end
        subject.count.should be(1)
      end

      it 'should delete older entries' do
        subject.count.should be(1)
        Timecop.travel(DateTime.now + 10.minutes) do
          subject.clean_up
        end
        subject.count.should be(0)
      end

    end # .clean_up
  end # clas methods
end # JabberTheHutt::SystemFetch::ArpEntry
