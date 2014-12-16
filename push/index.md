---
layout: default
---
# Push

It is sometimes useful for a client to be able to receive real-time updates from Podio when a new event occurs in the system. In Podio, there are many types of push events and they always occur on a specific resource, a.k.a. the "carrier object", for example a user or a conversation. For a detailed description of supported push events, see [this page](https://developers.podio.com/examples/push).

To subscribe to events on a specific object, you need to pass the `PKTPushCredential` instance available on domain objects that can act as carrier objects. Examples of these include the `PKTUser` and `PKTConversation`, both of which expose a `pushCredential` property.

For example, to subscribe to events for the logged in user:

{% highlight objective-c %}

[[PKTUser fetchCurrentUser] onSuccess:^ (PKTUser *user) {
  PKTPushSubscription *subscription = [PKTPushClient subscribeWithCredential:user eventBlock:^(PKTPushEvent *event) {
    NSLog(@"Received event of type: %@", @(event.eventType));
  }];
}];

{% endhighlight %}

To unsubscribe from the channel (normally before logging the user out or when leaving a screen), simply call the `unsubscribe` method on the returned `PKTPushSubscription` object:

{% highlight objective-c %}

PKTPushSubscription *subscription = ...
[subscription unsubscribe];

{% endhighlight %}