
![Travis Build](https://travis-ci.org/zlahham/live-voting.svg)

[![Cards in Waffle Cards Currently In Progress](https://badge.waffle.io/zlahham/live-voting.png?label=In%20Progress&title=In%20Progress)](https://waffle.io/zlahham/live-voting)

#Live-Voting


![Lovely Dog Relaxing After A Hard Day Of Getting Stuff Done](https://pbs.twimg.com/profile_images/2352976474/821r2dpq9gt8m1nwgy5r_400x400.png)

###Summary

- Live-voting is a realtime polling/voting tool that can be used in situations which have one person speaking in front of an audience.
- The primary benefit of using this tool is to get a quick heartbeat response from your audience. Or as we like to call it, a quick litmus test.
- A few example usages:
	- Educational context
	- Conferences
	- Annual General Meetings
	- Conference calls
- For a more in depth overview of our journey as a team through this project, please see the corresponding [wiki](https://github.com/zlahham/live-voting/wiki).

![Alt text](./charts_page.png)

###Final Version Features

>Speaker POV
- Login/ Sign up
- Create event
- Create questions with multiple choices
- Share link to Twitter
- Publish questions (1 at a time)
- Results shown live
- End event
- View summary

>Voter POV
- Visit URL
- Intro page

---

###User Stories

```
As a speaker
I would like to receive real time feedback from my audience
So I can gauge ***
```
```
As a speaker
I would like to receive real time feedback from my audience
So I can use the data after the session
```
```
As a speaker
I would like to ask specific questions at the appropriate time
So I can get appropriate responses accordingly
```
```
As an audience member
I would like to share my opinion in the form of a vote
So that I can make my mark
```
---
###Installation/Testing Instructions:

####Local installation
```
git clone git@github.com:zlahham/live-voting.git
cd live-voting
bundle
bin/rake db:create RAILS_ENV=test
bin/rake db:create RAILS_ENV=development
bin/rake db:migrate RAILS_ENV=test
bin/rake db:migrate RAILS_ENV=development
bin/rails s
```

####Local Testing
**NOTE**: You need to have Firefox installed if you want the tests to run properly, as we are using `selenium-webdriver` to run the JS tests. If you would like to use `capybara-webkit` instead, you can just uncomment line 23 in the Gemfile and comment line 24, followed by running `bundle`.
```
cd live-voting
rspec
```


---
###Team Members:

[Andrew](https://github.com/Yorkshireman)
[Ben](https://github.com/benhawker)
[Chris](https://github.com/christopheralcock)
[Lewis](https://github.com/ljones140)
[Zaid](https://github.com/zlahham)


<!--
You need to include this hidden file at /config/initializers/pusher.rb
```
Pusher.app_id = ENV['VOTING_PUSHER_APP_ID']
Pusher.key =  ENV['VOTING_PUSHER_KEY']
Pusher.secret = ENV['VOTING_PUSHER_SECRET']
``` -->
