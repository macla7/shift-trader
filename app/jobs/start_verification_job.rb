class StartVerificationJob < ApplicationJob
  queue_as :default

  def self.perform(to, channel='sms')
    @client = Twilio::REST::Client.new(Rails.application.credentials.twilio[:ACCOUNT_SID], Rails.application.credentials.twilio[:AUTH_TOKEN])
    channel = 'sms' unless ['sms', 'voice'].include? channel
    verification = @client.verify.services(Rails.application.credentials.twilio[:VERIFICATION_SID])
                                 .verifications
                                 .create(:to => to, :channel => channel)
    return verification.sid
  end

end
