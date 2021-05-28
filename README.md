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
  <li>Used this guide for requsts <a href="https://hackernoon.com/how-to-create-a-friendship-relation-on-rails-c01d3u4v">here</a> which was super handy.</li>
  <li>FROM ODIN-FACEBOOK PROJECT - >Seem to have got working the credentials.yml.enc file in config folder. When you use Vscode as an editor, you have to access it a bit of a funky way.. Like so -> 'EDITOR="code --wait" bin/rails credentials:edit'.</li>
  <li>TO come back to the websockets for a multitude of things.. Green circle next to user to show online. But also, this phone business from twilio..</li>
  <li>Twilio used these docs and accompaning git clone to work off <a href="https://www.twilio.com/docs/verify/quickstarts/ruby-rails">here</a></li>
</ul>


<h2>Current Problems to be fixed</h2>

<ul>
  <li>Seemed to have broken omniauth for the moment.. Fix this now.</li>
  <li>Will come back to facebook permissions with phone and avatar (profile pic).</li>
</ul>
