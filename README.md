# PodioKit

PodioKit is the Objective-C client library for the Podio API used in the Podio iOS app. It provides an easy interface for interacting with the Podio API and is responsible for request management and data mapping. If can be used as is or in combination with a storage layer like Core Data.

PodioKit uses ARC and requires a deployment target of >= iOS 5.0.

Note that development happens on the master branch, which means it is not guaranteed to be stable at all times. For the latest stable release, check the available tags.

## Running the Demo app

1. In the `DemoApp-Configuration.plist` file, define your API key's client ID and secret.
2. Run the DemoApp scheme to launch the app.

## Adding PodioKit to Your Project

### CocoaPods (Recommended)

Simply add the following line to your Podfile:

```ruby
pod 'PodioKit', '1.0.0'
```
	
If you feel adventurous and want to use the bleeding edge master branch, add the following line instead:

```ruby
pod 'PodioKit', :git => 'https://github.com/podio/podio-ios.git'
```
	
Then run `pod install` and you're good to go. Just include the header in any source file you want to use PodioKit from:

```objective-c
#import <PodioKit/PodioKit.h>
```

### As a sub-project

To add PodioKit to your project, follow these steps:

1. Clone the PodioKit repository from `https://github.com/podio/podio-ios`
2. Drag PodioKit.xcodeproj into the project navigator
3. Go to "Build Phases" for your project. Add the PodioKit target from the PodioKit project to under "Target Dependencies", and add libPodioKit.a under "Link Binary with Libraries"
4. In build settings for the target, set "User Header Search Paths" to point to the location of PodioKit. Also check the recursive box for this path. 
6. In build settings, also set the "Always Search User Paths" flag to YES
7. In build settings, under "Other Linker Flags" add `-ObjC` and `-all_load`. This will make sure categories in PodioKit are properly loaded
8. In your `<AppName>-Prefix.pch` file, add the following line:

	```objective-c
	#import <PodioKit/PodioKit.h>
	```

9. Add the following frameworks to your project:

		libz.dylib
		CFNewtwork.framework
		SystemConfiguration.framework
		MobileCoreServices.framework
		CoreData.framework

## Using PodioKit

The easiest way to get started is to take a look at the DemoApp project. However, in this section you'll find an introduction to the basic concepts.

### Configuring PodioKit

Before using PodioKit, you need to configure it. A good place to do this is in `application:didFinishLaunchingWithOptions:` in your app delegate. To get basic functionality and be able to make simple API requests, you just need the following:

```objective-c
[[PKAPIClient sharedClient] configureWithAPIKey:@"my-api-key" apiSecret:@"my-api-secret"];
```

You can generate an API key from your Podio account settings page, under _API keys_.

### Making a Simple API request

PodioKit provides a number of API interface classes. These interface classes are logically separated to match the [Podio API areas](https://developers.podio.com/doc).  Each interface class provides a set of methods that each returns a `PKRequest`. A `PKRequest` defines the HTTP request to make to the API, such as resource path, query parameters, request body etc. A `PKRequest` has an optional property `objectMapping` to provide an instance of `PKObjectMapping` (Described below). If set, the object mapping is used to map the response data to the native domain object class that corresponds to the provided object mapping class.

```objective-c
PKRequest *request = [PKTaskAPI requestForTaskWithId:123456];

[request startWithCompletionBlock:^(NSError *error, PKRequestResult *result) {
    if (!error) {
    	// Success
    	NSLog(@"Result: %@", result.parsedData);
    } else {
    	// Handle failure...
    }
}];
```

#### Mapping the Response to Native Domain Objects

To map the response data to a native domain object, you need to set the `objectMapping` property of the `PKRequest` object, like:

```objective-c
PKRequest *request = [PKTaskAPI requestForTaskWithId:123456];
request.objectMapping = [MYTaskMapping mapping];

[request startWithCompletionBlock:^(NSError *error, PKRequestResult *result) {
    if (!error) {
    	// Success
    	NSLog(@"Result: %@, %@", result.parsedData, result.resultData);
    } else {
    	// Handle failure...
    }
}];
```

Where `MYTaskMapping` might look something like this:

```objective-c
@implementation MYTaskMapping

- (void)buildMappings {
  [self hasProperty:@"taskId" forAttribute:@"task_id"];
  [self hasProperty:@"text" forAttribute:@"text"];  
}

@end
```
    
In order for this to work, you also have to make sure that you configure the `PKRequestManager` singleton with a mapping provider to allow it to look up your domain object class from the object mapping class. The following code should be added in your app delegate after the `configureWithClientId:secret:` call described above:

```objective-c
PKMappingProvider *provider = [[PKMappingProvider alloc] init];
[provider addMappedClassName:@"MYTask" forMappingClassName:@"MYTaskMapping"];

[PKRequestManager sharedManager].mappingCoordinator = [[PKDefaultMappingCoordinator alloc] initWithMappingProvider:provider];
```

A `PKMappingProvider` can be instantiated directly (as shown here), or subclassed. If subclassed, you should implement the `buildClassMap` method to add your mapping/domain class associations with the same `addMappedClassName:forMappingClassName` method used above.

### Object data mapping

Object data mapping is the process of creating and populating native domain objects with the JSON response returned by the API. PodioKit relies on [KVC](https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/KeyValueCoding/Articles/KeyValueCoding.html) to achieve this. It provides a generic way to map response data to native objects by defining reusable mapping definitions for remote resources using subclasses of PKObjectMapping for each object type. Object mappings can also be combined, nested and reused for multiple API operations. The data mapping strategy in PodioKit is inspired by [RestKit](http://restkit.org/).

There are a number of key classes and protocols that are a part of the mapping process:

#### PKMappableObject
A protocol required to be implemented by every native class that is used as the target domain object class for a PKObjectMapping instance. This protocol is needed by PKObjectMapper to determine things such as object identity.

#### PKObjectMapping
This class is subclassed to define object mappings for the response data to the native domain object’s value properties.

#### PKAttributeMapping
A class describing how an attribute should be mapped to a specific domain object property.

#### PKMappingProvider
Every client application should provide a custom subclass of this class or use the default mapping provider class provided by PodioKit to define the domain object class for each object mapping to be used within the application.

#### PKObjectMapper
The object mapper is the core of the mapping process and is responsible for evaluating and applying all the mapped properties to a single or collection of domain objects.

#### PKObjectMapperDelegate 
The delegate object to receive updates from the object mapper during the mapping process. For example, in the case of Core Data the delegate is notified once the mapping completes in order to save the changes.

#### PKObjectRepository
The object repository is an abstraction used to decouple the creation, lookup and deletion of domain objects. Its implementation differs depending on the underlying persistence layer and its interface is only concerned with object class and identity.

#### PKMappingCoordinator 
The mapping coordinator is responsible for providing each new request operation with an new object mapper. This is needed because a single NSManagedObjectContext instance can only be used on the thread that instantiated it. Hence, PodioKit needs to create a new object context for each concurrent background operation.

## Documentation

PodioKit uses [appledoc](http://gentlebytes.com/appledoc/) for documentation. However, many classes are still missing documentation but the ambition is to improve this going forward.

## Dependencies

PodioKit uses the following open source libraries:

* [AFNetworking](https://github.com/AFNetworking/AFNetworking) for networking.
* [Reachability](http://developer.apple.com/library/ios/#samplecode/Reachability/Introduction/Intro.html) for monitoring network availability.

These libraries can be found in the _Vendor_ subfolder.
