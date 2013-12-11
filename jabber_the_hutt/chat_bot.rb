module JabberTheHutt::ChatBot
  attr_reader :roster

  include EM::Xmpp::XmlParser::Nokogiri
  include EM::Xmpp::Helpers


  def ready
    super

    on_presence do |ctx|
      self.check_presence(ctx)
    end

    on_message do |ctx|
      self.reasonize_message(ctx)
    end

    on_exception(:anything) do |ctx|
      p "rescued error"
      raise ctx.env['error']
      ctx
    end

  end # #ready


  def reasonize_message(ctx)
    message = ctx.bit!(:message)
    puts "**** message from #{message.from}"
    self.get_handler(message.body).call(ctx)
    ctx
  end # #reasonize_message


  def check_presence(ctx)
    presence = ctx.bit(:presence)

    if presence.subscription_request?
      puts "**** accepting subscription from #{presence.from}"
      send_stanza presence.reply('type'=>'subscribed')
      presence.from.subscribe
      presence.from.add_to_roster
    end

    ctx #returns a ctx for subsequent handlers if any
  end # #check_presence

  def get_handler(message_body)
    case message_body
    when /workspace|space/mi
      method(:where_is_here)
    else
      method(:make_jokes)
    end
  end # #get_handler

  def make_jokes(ctx)
    self.answer(ctx, 'Talk to the hand')
  end # #make_jokes

  def where_is_here(ctx)
    self.answer(ctx, JabberTheHutt::Visitors.get_names)
  end # #where_is_here

  #########################
  ##  Protected Methods  ##
  #########################
  #
  protected

  def answer(ctx, answer)
    conv = conversation(ctx.bit(:message).from)
    if conv 
      conv.resume ctx
    else
      start_conversation(ctx, ctx.bit(:message).from.to_s) do |c|
        stanza = ctx.bit(:message).reply
        msg    = Nokogiri::XML(stanza.xml)
        body   = Nokogiri::XML::Element.new('body', msg)
        body.content = answer
        msg.search('message').first.add_child(body)
        stanza.instance_variable_set(
          '@xml', 
          msg.to_xml(:save_with => Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)
        )

        send_stanza(stanza)
      end
    end
  end # #answer
end # JabberTheHutt::ChatBot
