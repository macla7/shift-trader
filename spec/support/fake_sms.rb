class FakeSMS
  # fake twilio API following https://thoughtbot.com/blog/testing-sms-interactions
  # but making my own adjustments to make the code actually work..
  Message = Struct.new(:to, :code, :sid, :status)

  @@messages = []

  def initialize(_account_sid, _auth_token)
  end

  def messages
    self
  end

  def self.messages
    @@messages
  end

  def verify
    self
  end

  def services(blah)
    self
  end

  def verifications
    self
  end

  def verification_checks
    self
  end

  def create(to, channel = 'sms', code = '0')
    mess = Message.new(to, '1234', 474, 'approved')
    @@messages.push(mess)
    return mess
  end
end