# PodioKit 

[![Build Status](https://travis-ci.org/podio/podio-objc.png?branch=2.0-develop)](https://travis-ci.org/podio/podio-objc)

PodioKit is a Objective-C client library for the [Podio API](https://developers.podio.com/). It provides an easy way to integrate your iOS and Mac apps with Podio.

PodioKit uses ARC and supports iOS 6.0 or above and Mac OS X 10.8 and above. It depends on AFNetworking 2.x for the HTTP communication with the Podio API.

PodioKit 2.0 is currently in beta and being actively developed. To use the latest stable version, use one of the official 1.x [releases](https://github.com/podio/podio-objc/releases).

## Integrate with an existing project

We encourage you to use [CocoaPods](http://cocoapods.org/) to integrate PodioKit with your existing project. CocoaPods is a dependency manager for Objective-C that makes dealing with dependencies a breeze.

First, make sure your have integrated CocoaPods with your project. If you do not, there is a great guide available [here](http://guides.cocoapods.org/using/getting-started.html).

Once CocoaPods is installed, add the following line to your `Podfile`:

```
pod 'PodioKit'
```
	
Then run `pod install` from the command line.

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

### Authentication

The Podio API supports multiple ways of authenticating a client. PodioKit provides three primary options:

* Authenticate with user/password
* Authenticate as an app
* Automatically authenticate as an app

We will describe when and how to use these methods below. For more details on authentication and the Podio API, more information can be found [here](https://developers.podio.com/authentication).

#### Authenticate as a user

This option is great when you want to have every user of your client app to log in using their own Podio account and as such have access to the content of their entire Podio account.

Here is how to authenticate as a user:

```objective-c
[PodioKit authenticateAsUserWithEmail:@"myname@mydomain.com" password:@"p4$$w0rD" completion:^(PKTResponse *response, NSError *error) {
	if (!error) {
		// Successfully authenticated
	} else {
		// Failed to authenticate, double check your credentials
	}
}];
```

#### Authenticate as an app

Most people know that you can log into Podio using an email and password. But it is also possible for any individual Podio app to authenticate as itself using it's unique app token. The client will then be able to create new items within that app, without ever being authenticated as a user.

This option is useful when you want any user of your client app to interact with the same [Podio app](https://developers.podio.com/doc/applications), regardless of who they are. This might be an app that you our someone else created.

The major benefit of this method is that it requires no log in action for the user of your app, as they will be authenticated as the Podio app itself.

To authenticate as the app, you need to find the app ID and token for your app. When logged into Podio, navigate to the app and click the small wrench icon in the top right. Then click "Developer" in the drop down menu that appears. That should take you to a page showing your app's ID and token.

Here is an example of how to authenticate as an app:

```objective-c
[PodioKit authenticateAsAppWithID:123456 token:@"my-app-token" completion:^(PKTResponse *response, NSError *error) {
	if (!error) {
		// Successfully authenticated
	} else {
		// Failed to authenticate, double check your credentials
	}
}];
```

#### Automatically authenticate as an app

Instead of explicitly authenticating as an app as shown in the example above, there is also an option to automatically authenticate as an app. This means that instead of choosing yourself when to authenticate the app, you simply provide PodioKit with the app ID and token and it will automatatically handle the authentication step when you try to make an API operation. This is usually the prefereable option as it means you do not have to handle the authentication step yourself. To authenticate automatically, just make the following call after setting up your API key and secret:

```objective-c
[PodioKit authenticateAutomaticallyAsAppWithID:123456 token:@"my-app-token"];
```

### Fetching items

[Apps](https://developers.podio.com/doc/applications) and [items](https://developers.podio.com/doc/items) are the corner stones of the Podio platform. An app is a container of multiple items. You can think of an app as a set of fields of different types, like the columns in a spreadsheet. The items in that app are then equivalent to the rows in the spreadsheet, i.e. the entires with one or more values for each field.

There are mupltiple types of fields in an app:

* Title
* Text
* Number
* Image
* Date
* Relation
* Contact
* Money
* Progress
* Location
* Duration
* Embed
* Calculation (read-only)
* Category

To create an item, use the class method on `PKTItem`:

```objective-c
[PKTItem fetchItemWithID:1234 completion:^(PKTItem *item, NSError *error) {
  if (!error) {
    NSLog(@"Fetched item with ID: %@", @(item.itemID));
  }
}];
```

To fetch a list of items in an app, there is another handy method on `PKTItem`:

```objective-c
[PKTItem fetchItemsInAppWithID:1234 offset:0 limit:30 completion:^(NSArray *items, NSUInteger filteredCount, NSUInteger totalCount, NSError *error) {
  if (!error) {
    NSLog(@"Fetched %@ items out of a total of @%", @(filteredCount), @(totalCount));
  }
}];
```

### Create a new item

To create an item, simply use the class methods on `PKTItem`:

```objective-c
PKTItem *item = [PKTItem itemForAppWithID:1234];
item[@"title"] = @"My first item";
item[@"description"] = @"This is my first item of many.";

[item saveWithCompletion:^(PKTResponse *response, NSError *error) {
  if (!error) {
    NSLog(@"Item saved with ID: %@", @(item.itemID));
  } else {
    // Handle error...
  }
}];
```

### Upload a file

You can easily upload a file to Podio to attach to an item or comment. To do so, just use the upload methods provided by the `PKTFile` class. Here is an example on how you can upload a UIImage instance as a JPEG to Podio on iOS:

```objective-c
UIImage *image = [UIImage imageNamed:@"some-image.jpg"];
NSData *data = UIImageJPEGRepresentation(image, 0.8f);

[PKTFile uploadWithData:data fileName:@"image.jpg" mimeType:@"image/jpeg" completion:^(PKTFile *file, NSError *error) {
  if (!error) {
    NSLog(@"File uploaded with ID: %@", @(file.fileID));
  }
}];
```

### Add a comment

Podio supports commenting on many things including items, tasks, status posts etc. To add a new comment, use the methods provided by the `PKTComment` class:

```objective-c
[PKTComment addCommentForObjectWithText:@"My insightful comment" referenceID:1234 referenceType:PKTReferenceTypeItem completion:^(PKTComment *comment, NSError *error) {
  if (!error) {
    NSLog(@"Comment posted with ID: %@", @(comment.commentID));
  }
}];
```