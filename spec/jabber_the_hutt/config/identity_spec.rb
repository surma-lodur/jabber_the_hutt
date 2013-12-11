# encoding: UTF-8
require 'spec_helper'

describe JabberTheHutt::Config::Identity do
  let(:identities) do
YAML.load("
  'Günter Gras':
    macs: 
      - Ax:xx:xx:xx:xx
    contacts:
      email: 'günter@gras.de'
  'Günter Kastenfrosch':
    macs:
      - Bx:xx:xx:xx:xx
      - Cx:xx:xx:xx:xx
    contacts:
      jabber: 'frosch@janosh.de'
")
  end


  subject { JabberTheHutt::Config::Identity }
  describe '.setup' do
    it 'should build identities' do
      subject.setup(identities)

      subject.should have(3).macs
      subject.macs['Bx:xx:xx:xx:xx'].object_id.should be(
        subject.macs['Cx:xx:xx:xx:xx'].object_id
      )

      subject.macs['Ax:xx:xx:xx:xx'].name.should match("Günter Gras")

    end
  end # .setup
end
