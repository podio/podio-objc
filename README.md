# PodioKit 

[![Build Status](https://travis-ci.org/podio/podio-objc.png?branch=2.0-develop)](https://travis-ci.org/podio/podio-objc)

PodioKit is a Objective-C client library for the [Podio API](https://developers.podio.com/). It provides an easy way to integrate your iOS and Mac apps with Podio.

PodioKit uses ARC and is based on NSURLSession, which means it supports iOS 7.0 and above and Mac OS X 10.9 and above.

PodioKit 2.0 is currently in beta and is being actively developed. We encourage contributions through pull requests and the Github issue tracker.

## Integrate with an existing project

We encourage you to use [CocoaPods](http://cocoapods.org/) to integrate PodioKit with your existing project. CocoaPods is a dependency manager for Objective-C that makes dealing with dependencies a breeze.

First, make sure your have integrated CocoaPods with your project. If you do not, there is a great guide available [here](http://guides.cocoapods.org/using/getting-started.html).

Once CocoaPods is installed, add the following line to your `Podfile` to use the latest code from the master branch:

```ruby
pod 'PodioKit', :git => 'https://github.com/podio/podio-objc.git', :branch => 'master'
```

Then run `pod install` from the command line.

To use the latest official beta release, use the following instead:

```ruby
pod 'PodioKit', '~> 2.0.0-beta'
```

After that you are ready to start using PodioKit by importing the main header file where you would like to use it in your project:

```objective-c
#import <PodioKit/PodioKit.h>
```

Optionally, you can use PodioKit as a framework directly by copying the source files directly into your Xcode project.

## Using PodioKit

### Set up your API key and secret

Before you can talk to the Podio API, you need to generate a new API key for your application from your "Account Settings" page on Podio. You can find instructions on how to do so [here](https://developers.podio.com/api-key).

Once you have a key and secret, you need to configure PodioKit to use it. To do so, add the following code to your `application:didFinishLaunching:options:` method in your app delegate:

```objective-c
[PodioKit setupWithAPIKey:@"my-api-key" secret:@"my-secret"];
```
	
That's it! You are now good to start using PodioKit.

## Getting Started & Documentation

You can find a getting started guide and full documentation over at the [PodioKit Github pages](http://podio.github.io/podio-objc/).