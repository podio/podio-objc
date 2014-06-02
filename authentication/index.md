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

Whenver the the authentication state changes, the `PKTClientAuthenticationStateDidChangeNotification` notification is posted. This can be useful to observe for changing the state of your UI or show a login screen.

For more details about authentication and the Podio API, more information can be found [here](https://developers.podio.com/authentication).

## Authenticate as a user

This option is great when you want to have every user of your client app to log in using their own Podio account and as such have access to the content of their entire Podio account.

Here is how to authenticate as a user:

{% highlight objective-c %}
[PodioKit authenticateAsUserWithEmail:@"myname@mydomain.com" password:@"p4$$w0rD" completion:^(PKTResponse *response, NSError *error) {
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
[PodioKit authenticateAsAppWithID:123456 token:@"my-app-token" completion:^(PKTResponse *response, NSError *error) {
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