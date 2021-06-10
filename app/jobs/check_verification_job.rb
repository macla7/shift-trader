class CheckVerificationJob < ApplicationJob
  queue_as :default

  def self.perform(phone, code, user_id)
    @client = Twilio::REST::Client.new(Rails.application.credentials.twilio[:ACCOUNT_SID], Rails.application.credentials.twilio[:AUTH_TOKEN])
    verification_check = @client.verify.services(Rails.application.credentials.twilio[:VERIFICATION_SID])
                                .verification_checks
                                .create(:to => phone, :code => code)
    if verification_check.status == 'approved'
      user ||= User.find_by(id: user_id)
      user.verified = true
      user.save!
    end
  end
end
