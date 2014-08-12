---
layout: default
---
# Authentication & Session Management

The Podio API supports multiple ways of authenticating a client. PodioKit provides three primary options:

* Authenticate with user/password
* Authenticate as an app
* Automatically authenticate as an app

Each of them are described below. The client is considered to be authenticated once it has obtained a valid OAuth2 token. You can easily check if the client is authenticated:

{% highlight objective-c %}
if ([PodioKit isAuthenticated]) {
  // The client is authenticated
}
{% endhighlight %}

The authentication state is kept by a singleton instance of [`PKTClient`](https://github.com/podio/podio-objc/blob/master/PodioKit/Core/PKTClient.h).

Whenver the the authentication state of the client changes, meaning the token is updated, the `PKTClientAuthenticationStateDidChangeNotification` notification is posted. This can be useful to observe for changing the state of your UI or show a login screen.

For more details about authentication and the Podio API, more information can be found [here](https://developers.podio.com/authentication).

## Authenticate as a user

This option is great when you want to have every user of your client app to log in using their own Podio account and as such have access to the content of their entire Podio account.

Here is how to authenticate as a user:

{% highlight objective-c %}
PKTAsyncTask *authTask = [PodioKit authenticateAsUserWithEmail:@"myname@mydomain.com" password:@"p4$$w0rD"];

[authTask onComplete:^(PKTResponse *response, NSError *error) {
  if (!error) {
    // Successfully authenticated
  } else {
    // Failed to authenticate, double check your credentials
  }
}];
{% endhighlight %}

## Authenticate as an app

Most people know that you can log into Podio using an email and password. But it is also possible for any individual Podio app to authenticate as itself using it's unique app token. The client will then be able to create new items within that app, without ever being authenticated as a user.

This option is useful when you want any user of your client app to interact with the same [Podio app](https://developers.podio.com/doc/applications), regardless of who they are. This might be an app that you our someone else created.

The major benefit of this method is that it requires no log in action for the user of your app, as they will be authenticated as the Podio app itself.

To authenticate as the app, you need to find the app ID and token for your app. When logged into Podio, navigate to the app and click the small wrench icon in the top right. Then click "Developer" in the drop down menu that appears. That should take you to a page showing your app's ID and token.

Here is an example of how to authenticate as an app:

{% highlight objective-c %}
PKTAsyncTask *authTask = [PodioKit authenticateAsAppWithID:123456 token:@"my-app-token"];

[authTask onComplete:^(PKTResponse *response, NSError *error) {
  if (!error) {
    // Successfully authenticated
  } else {
    // Failed to authenticate, double check your credentials
  }
}];
{% endhighlight %}

## Automatically authenticate as an app

Instead of explicitly authenticating as an app as shown in the example above, there is also an option to automatically authenticate as an app. This means that instead of choosing yourself when to authenticate the app, you simply provide PodioKit with the app ID and token and it will automatatically handle the authentication step when you try to make an API operation. This is usually the prefereable option as it means you do not have to handle the authentication step yourself. To authenticate automatically, just make the following call after setting up your API key and secret:

{% highlight objective-c %}
[PodioKit authenticateAutomaticallyAsAppWithID:123456 token:@"my-app-token"];
{% endhighlight %}

## Saving and restoring a session across app launches

If your app is terminated, the shared `PKTClient` instance will no longer have a token once your app is re-launced. This means that if you want the previous user session to live on, you need to store the authentication token in the Keychain when it changes and restore it from the Keychain when the app is re-launced. Luckily, PodioKit can take care of that for you!

PodioKit provides a protocol called `PKTTokenStore` and a concrete class `PKTKeychainTokenStore` which stores the token in the iOS or OS X Keychain. All you need to do is add the following line after your call to `-setupWithAPIKey:secret:` in `-application:didFinishLaunchingWithOptions:`:

{% highlight objective-c %}
...
// [PodioKit setupWithAPIKey:PODIO_API_KEY secret:];

[PodioKit automaticallyStoreTokenInKeychainForCurrentApp];
// or
[PodioKit automaticallyStoreTokenInKeychainForServiceWithName:@"MyApp"];
...
{% endhighlight %}

This line takes care of configuring the shared `PKTClient` instance with an instance of `PKTKeychainTokenStore` and restores any previous token from the Keychain. If you want to expliticly restore the token, you can call the `restoreTokenIfNeeded` method on `PKTClient` directly. If you are feeling real adventurous you can even implement your own class conforming to `PKTTokenStore` to store the token anywhere other than the Keychain. You can then set the `tokenStore` property on the shared `PKTClient` instance like:

{% highlight objective-c %}
...
[PKTClient currentClient].tokenStore = [[MYOwnTokenStore alloc] init];
[[PKTClient currentClient] restoreTokenIfNeeded];
...
{% endhighlight %}

Note that we would not recommend doing this as the Keychain is the most secure container available.