---
layout: default
---
# Basic Principles of Asynchronicity

PodioKit's main responsibility os making request to the Podio API. To do so, it needs to provide a mean of handling asynchronous 
method calls. PodioKit uses a [future](http://en.wikipedia.org/wiki/Futures_and_promises)-based approach where each asynchronous method returns an instance of `PKTAsyncTask`. You can then register callbacks (`onSuccess:`, `onError:` and `onComplete:`) on this tasks that will be called according to the following rules:

* If the task has not yet completed, the callback will be kept and executed on the main thread upon the completion of the task. Registered callbacks on a task are not guaranteed to be called in the order they were registerd.
* If the task has alread completed, the callback will be executed immediately with the result of the task.
* A task can only succeed or fail, not both.
* a task can only succeed or fail once, it cannot be retried or reset.

To register a callback, you have three options:

The `onSuccess:` method is used to register callbacks to be executed if the task succeeds, meaning it does not generate an error:

{% highlight objective-c %}
PKTAsyncTask *task = [SomeClass someAsynchronousMethod];

[task onSuccess:^(PKTResponse *response) {
  // The task finished successfully
}];
{% endhighlight %}

The `onError:` method can be used to register callbacks for the error case:

{% highlight objective-c %}
PKTAsyncTask *task = [SomeClass someAsynchronousMethod];

[task onError:^(NSError *error) {
  // The task failed and returned an error
}];
{% endhighlight %}

If you are interested in both the success and error case at the same time, you can use the `onComplete:` method to register a callback for when either happens:

{% highlight objective-c %}
PKTAsyncTask *task = [SomeClass someAsynchronousMethod];

[task onComplete:^(PKTResponse *response, NSError *error) {
  if (!error) {
    // Task succeeded
  } else {
    // Task failed
  }
}];
{% endhighlight %}

The main advantage of modelling asynchronisity with futures is that you can chain tasks together to acheive some things. PodioKit provides a few combinator methods to combine sub-tasks in to bigger tasks. Consider for example if you first want to upload a task, then attach it to an object. With a callback approach you would have to nest your callback handlers:

{% highlight objective-c %}
NSData *data = ...; // Some image data

[PKTFile uploadWithData:data fileName:@"image.jpg" completion:(PKTFile *file, NSError *error) {
  if (!error) {
    [file attachWithReferenceID:1234 referenceType:PKTReferenceTypeItem completion:^(PKTResponse *response, NSError *error) {
      if (!error) {
        // Handle success...
      } else {
        // Handle failure...
      }
    }];
  } else {
    // Handle failure...
  }
}];
{% endhighlight %}

You can see that we have to handle the error case twice. With a task based approach, we can instead use the `pipe:` combinator method which takes a block that generates a new task based on the result of the first task once completed:

{% highlight objective-c %}
NSData *data = ...; // Some image data

PKTAsyncTask *uploadTask = [PKTFile uploadWithData:data fileName:@"image.jpg"];

PKTASyncTask *task = [uploadTask pipe:^PKTAsyncTask *(PKTFile *file) {
  return [file attachWithReferenceID:1234 referenceType:PKTReferenceTypeItem];
}];

[task onComplete:^(PKTResponse *response, NSError *error) {
  if (!error) {
    // Handle success...
  } else {
    // Handle failure...
  }
}];

{% endhighlight %}

Here, we only have to handle the error case once and we do not end up with deeply nested code blocks. There are also other useful combinator methods such as `when:`, `then:` and `map:` available.