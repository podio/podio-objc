---
layout: default
---
# PodioKit 

PodioKit is a Objective-C client library for the [Podio API](https://developers.podio.com/). It provides an easy way to integrate your iOS and Mac apps with Podio.

PodioKit uses ARC and is based on NSURLSession, which means it supports iOS 7.0 and above and Mac OS X 10.9 and above.

PodioKit 2.0 is being actively developed by the Podio team. We encourage contributions through pull requests and the Github issue tracker.

## Integrate with an existing project

We encourage you to use [CocoaPods](http://cocoapods.org/) to integrate PodioKit with your existing project. CocoaPods is a dependency manager for Objective-C that makes dealing with code dependencies easy.

First, make sure your have integrated CocoaPods with your project. If you have not, there is a great guide available [here](http://guides.cocoapods.org/using/getting-started.html).

Once CocoaPods is installed, add the following line to your `Podfile` to use the latest stable release:

{% highlight ruby %}
pod 'PodioKit', '~> 2.0'
{% endhighlight %}

Then run `pod install` from the command line.

After that you are ready to start using PodioKit by importing the main header file where you would like to use it in your project:

{% highlight objective-c %}
#import <PodioKit/PodioKit.h>
{% endhighlight %}

Alternatively, you can use the PodioKit source directly by copying the source files directly into your Xcode project.

## Using PodioKit

### Set up your API key and secret

Before you can talk to the Podio API, you need to generate a new API key for your application from your "Account Settings" page on Podio. You can find instructions on how to do so [here](https://developers.podio.com/api-key).

Once you have a key and secret, you need to configure PodioKit to use it. To do so, add the following code to your `application:didFinishLaunching:options:` method in your app delegate:

{% highlight objective-c %}
[PodioKit setupWithAPIKey:@"my-api-key" secret:@"my-secret"];
{% endhighlight %}
	
That's it! You are now good to start using PodioKit.