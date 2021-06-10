# README

This README would normally document whatever steps are necessary to get the application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

<h2>Things to down the line:</h2>
<ul>
  <li>Add action_mailer for devise to production environment</li>
  <li>Food for thought for later, do I want a seperate phone number model for Users if I want to require phone number verification during registration <a href="https://stackoverflow.com/questions/32129608/adding-phone-number-to-user-model">here</a>.</li>
  <li>TO come back to the websockets for a multitude of things.. Green circle next to user to show online. But also, this phone JavaScript business form from twilio..</li>
  <li>Will come back to facebook permissions with phone and avatar (profile pic).</li>
  <li>SO want to be able to make user without phone, only email necessary, cause this is all facebook will give me at this point lol. <ahref="https://developers.facebook.com/docs/permissions/reference">link</a>.</li>
  <li>Notifications model for User? Has_many relationship, only index view?</li>
  <li>listens for unconfirmed invites to groups.. Then later, seems like a JS thing, will listen for Likes and Comments.</li>
</ul>

<h2>Errors fixed and brief on how</h2>
<ul>
  <li>FROM ODIN-FACEBOOK PROJECT - >Seem to have got working the credentials.yml.enc file in config folder. When you use Vscode as an editor, you have to access it a bit of a funky way.. Like so -> 'EDITOR="code --wait" bin/rails credentials:edit'.</li>
  <li>Used this guide for requsts <a href="https://hackernoon.com/how-to-create-a-friendship-relation-on-rails-c01d3u4v">here</a> which was super handy.</li>
  <li>Twilio used these docs and accompaning git clone to work off <a href="https://www.twilio.com/docs/verify/quickstarts/ruby-rails">here</a></li>
  <li>Omniauth broke after users got telephone. Just needed to make sure telephone wasn't required</li>
  <li>Solved phone uniqueness directly on the database, so that it can also be nil. This means when a user signs up, they don't HAVE to give their phone number.. but it will be impossible to verify themselves without one..</li>
  <li>Used this guide <a href="https://github.com/omniauth/omniauth/wiki/Managing-Multiple-Providers">here</a>, and a few others similar to it to sort out having multiple ways to identify (or authenticate). Essentially made an Identify model with belongs_to User. This then can word in 3 ways. Identify model can be linked to User when already logged in. Can be used to log in. Can be used to sign up.</li>
  <li>Followed bottom of <a href="https://www.reddit.com/r/rails/comments/5eufg4/devise_and_omniauth_set_password_after/">this</a> post for setting a user's password, after they've intially signed up with an omniauth method. This way they can then re log back in with email and password.</li>
  <li>Implementation of invite model was outlined <a href="https://coderwall.com/p/rqjjca/creating-a-scoped-invitation-system-for-rails">here</a>.</li>
  <li>To DRY up feature specs, found this great <a href="https://stackoverflow.com/questions/32628093/using-devise-in-rspec-feature-tests">SO post</a> about making a spec/support Auth module to help with logging in and out with devise/warden. This is OP. Two things not really in the post.<ul>
    <li>I had too include this at top of rails_helper -> " require 'support/auth' " in order to load module I think.</li>
    <li> I had to include these two lines in the RSpec.configure block<br />include Warden::Test::Helpers<br />config.include Auth, type: :feature</li>
  </ul></li>
</ul>

<h2>Current Problems to be fixed</h2>
<ul>

  <li>TEST WEEK
    <ul>
      <li>DONE - Models</li>
      <li>Jobs</li>
      <li>Controllers</li>
      <li>Done - Features</li>
      <li>Presenters?</li>
      <li>Views</li>
      <li>FINAL BOSS - Twilio sending phone</li>
      <li>Done - Omniauth</li>
    </ul>
  </li>

  <li>GREATEST HICCUP YET
    <ul>
      <li>Using Delayed job... daemons bin/delayed scripting.. It just won't work..</li>
      <li>I've found soooo many posts of people running into the same issue and then no one being able to give them a straight answer..? Or commonly, no one answering at all... Think it's time to set this one to the side for the moment. I know how to use it in development with the 'rake jobs:work' command, which apparently does the same thing anyway.. Just got to open up another terminal tab to be running this.</li>
      <li>Maybe, just maybe.. it's for some reason just not liking the development mode (daemons scripting that is).. idk..</li>
      <li>Either way, not even sure if I should be using delayed job, when compared to the other options out there like resque, sidkiq, etc.. (mispelling warning lol).</li>
    </ul>
  </li>
  
</ul>


