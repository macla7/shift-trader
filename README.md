# README

This README would normally document whatever steps are necessary to get the
application up and running.

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
  <li>Notifications model for User? Has_many relationship, only index view?<li>
  <li>listens for unconfirmed invites to groups.. Then later, seems like a JS thing, will listen for Likes and Comments.<li>
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
</ul>

<h2>Current Problems to be fixed</h2>
<ul>
  <li>Adding accepting Invites from other users (when logged in as host)</li>
  <li>Adding accept invites to groups as a User.. Atm just thinking on the workplace index.</li>
  <li>Should make request to join button inacitve.</li>
  <li>Not duplicating on already accepted invites</li>

  <li>THE GREAT REFEACTOR</li>
  <li>Fixed up invite controller so a lot more of the invite logic is on model. It's on User model atm, which is questionable.. should probably be on the Invite model itself but anyway.. OFF the controller.</li>
  <li>Next step is to refactor my twilio into a delayed job with high priority..<li>
  <li>Refactor those ugly views ahhaha</li>
</ul>


