---
title: Deploying to Heroku on an iPad
date: 2020-05-24 17:00
tags: iPad
---

# Deploying to Heroku on an iPad

In this article, I'll describe how to deploy applications to Heroku from [Working Copy](https://workingcopyapp.com/) on an iPad.

The typical way to deploy a Heroku app is to push to your application's Git URL, which you get either from the Heroku command line tools or from the application's web dashboard.

In order to push new changes, you'll need to authenticate with your Heroku command line credentials. These aren't the same as your regular login credentials. If you try and use those (like I did), nothing will happen.

There are [instructions for this in the Working Copy documentation](https://workingcopyapp.com/manual/heruko-remotes), but I couldn't quite follow them exactly. This is what I had to do to get this working:

The first step requires authenticating with the [Heroku Command Line Toolbelt](https://devcenter.heroku.com/articles/heroku-cli), which (unfortunately) has to be done on a Mac:

1. Install Heroku's Command Line Toolbelt.
2. Run `heroku login`
3. A Heroku sign in prompt will open in your browser. Enter your details if needed and continue.
4. Now the Heroku command line tool is authenticated, you can access.

Then, on your iPad:

1. Grab the Heroku application's git URL from application settings.
2. In Working Copy, add a new remote for this repository. Name it `heroku`, and set its URL to the URL we copied from Heroku in the previous step.
3. Tap 'Test'. You should get a login prompt: this is where you'll need to enter your regular Heroku email, and then the password you got from logging in with the Heroku Command Line Toolbelt.

Once done, you should be able to successfully push changes to the `heroku`remote to trigger an update.