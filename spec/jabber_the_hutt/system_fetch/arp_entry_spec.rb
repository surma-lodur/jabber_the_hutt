require 'spec_helper'

describe JabberTheHutt::SystemFetch::ArpEntry do


  context 'class methods' do
    subject { JabberTheHutt::SystemFetch::ArpEntry }

    it 'should register a mac' do
      subject.register('ab:cd')
      subject.exists?(:mac => 'ab:cd').should be_true
    end

  end # clas methods

end # JabberTheHutt::SystemFetch::ArpEntry
