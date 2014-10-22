---
layout: default
---

# Local storage  & caching

Sometimes only relying on in-memory data is not enough. For example, you might want to persist fetched Podio content to disk across application launches.

All domain objects in PodioKit inherits from `PKTModel`. This class is conforms to the `NSCoding` protocol, meaning every subclass can be serialized, for example using `NSKeyedArchiver`/`NSKeyedUnarchiver`. Using PodioKit in your application, this gives you a lot of flexibility on how to persist these domain objects should you find the need.

For convenience, PodioKit provides a very simple key/value solution for storing objects conforming to `NSCoding` on disk with the `PKTDatastore` class.

## Using PKTDatastore

`PKTDatastore` is a thread-safe, disk based key/value store. It can persist any object conforming to `NSCoding` and does so by simply archiving it to disk on a background thread. It also contains its own internal caching mechanism to avoid hitting the disk on every access. This internal cache will, on iOS only, be cleared if a low memory warning is issued.

To use `PKTDatastore`, you can either use the singleton instance or create your own store:

{% highlight objective-c %}
PKTDatastore *store = [PKTDatastore sharedStore];
// or...
PKTDatastore *store = [PKTDatastore storeWithName:@"MyStore"];
{% endhighlight %}

The latter will create a seperate location on disk where all objects will be stored. To store an object for a specific key, use the `storeObject:forKey:` method or subscripting:

{% highlight objective-c %}
NSArray *numbers = @[@1, @2, @3];

[[PKTDatastore sharedStore] storeObject:numbers forKey:@"MyNumbers"];
// or...
[PKTDatastore sharedStore][@"MyNumbers"] = numbers;
{% endhighlight %}

To retrieve an object from the store, you can use either the synchronous `storedObjectForKey:` or the asynchronous `fetchStoredObjectForKey:`. We encourage using the latter to keep your application responsive and istead register a completion handler on the `PKTAsyncTask` returned from the method:

{% highlight objective-c %}
NSArray *numbers = [[PKTDatastore sharedStore] storedObjectForKey:@"MyNumbers"];

// or...

[[PKTDatastore sharedStore] fetchStoredObjectForKey:@"MyNumbers"] onComplete:^(NSArray *numbers, NSError *error) ^{
  // Use the numbers...
}];
{% endhighlight %}