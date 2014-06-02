---
layout: default
---
# Working with Files

## Upload a file

You can easily upload a file to Podio to attach to an item or comment. To do so, just use the upload methods provided by the `PKTFile` class. Here is an example on how you can upload a UIImage instance as a JPEG to Podio on iOS:

{% highlight objective-c %}
UIImage *image = [UIImage imageNamed:@"some-image.jpg"];
NSData *data = UIImageJPEGRepresentation(image, 0.8f);

[PKTFile uploadWithData:data fileName:@"image.jpg" mimeType:@"image/jpeg" completion:^(PKTFile *file, NSError *error) {
  if (!error) {
    NSLog(@"File uploaded with ID: %@", @(file.fileID));
  }
}];
{% endhighlight %}

To add a file to an item, use the `addFile:` method on `PKTItem`:

{% highlight objective-c %}
PKTItem *item = ...
PKTFile *file = ...

[item addFile:file];

[item saveWithCompletion:^(PKTResponse *response, NSError *error){
  // Item saved with the file added
}];
{% endhighlight %}

You can also attach a file to any object by supplying its reference type and ID:

{% highlight objective-c %}
PKTFile *file = ...
[file attachWithReferenceID:1234 referenceType:PKTReferenceTypeItem completion:^(PKTResponse *response, NSError *error) {
  if (!error) {
    // File successfully attached to item with ID 1234
  }
}];
{% endhighlight %}