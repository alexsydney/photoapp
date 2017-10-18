# README

* [simple_form][gem 'simple_form']
* [acts_as_votable][gem 'acts_as_votable', '~> 0.10.0']

* Test associations between User and Profile in Rails Console
  ```
  rails c

  # get the first user from the User table in the database
  u1 = User.all.first
  p1 = Profile.create(username: "test", user_id: 1)
  u1.profile
  p1.user
  ```

* Install dependencies
  ```
  brew install graphicsmagick
  ```
