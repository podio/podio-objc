---
layout: default
---
# Working with Comments

## Add a comment

Podio supports commenting on many things including items, tasks, status posts etc. To add a new comment, use the methods provided by the `PKTComment` class:

{% highlight objective-c %}
PKTAsyncTask *task = [PKTComment addCommentForObjectWithText:@"My insightful comment" referenceID:1234 referenceType:PKTReferenceTypeItem];

[task onComplete:^(PKTComment *comment, NSError *error) {
  if (!error) {
    NSLog(@"Comment posted with ID: %@", @(comment.commentID));
  }
}];
{% endhighlight %}