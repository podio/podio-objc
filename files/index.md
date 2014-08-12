---
layout: default
---
# Working with Files

Files on Podio are represented by the `PKTFile` class in PodioKit. It will be the type returned for the files of any object that can have associated files such as items, tasks or comments etc.

## Download a file

To download the contents of a file from Podio you have two options. The first one is to download the content directly into memory and get an `NSData` object back. This is appropriate for smaller files and can be done with the following code:

{% highlight objective-c %}
PKTFile *file = ...;

PKTAsyncTask *downloadTask = [file download];

[downloadTask onComplete:^(NSData *data, NSError *error) {
  if (data) {
    // Success, do something the data...
  } else {
    // Something went wrong, handle error...
  }
}];
{% endhighlight %}

The second option is to save the file directly to disk to avoid keeping its data in memory and risking termination by the OS due to excessive memory use. To do this, there is a second download method on `PKTFile` which allows you to specify a save path:

{% highlight objective-c %}
PKTFile *file = ...;
NSString *savePath = ...; // The local file path where you wish to save the file

PKTAsyncTask *downloadTask = [file downloadToFileWithPath:savePath];

[downloadTask onComplete:^(BOOL success, NSError *error) {
  if (success) {
    // Success, now we can load it from disk as needed...
    NSData *data = [NSData dataWithContentsOfFile:savePath];
  } else {
    // Something went wrong, handle error...
  }
}];
{% endhighlight %}

## Upload a file

You can easily upload a file to Podio to attach to an item or comment. To do so, just use the upload methods provided by the `PKTFile` class. Here is an example on how you can upload a UIImage instance as a JPEG to Podio on iOS:

{% highlight objective-c %}
UIImage *image = [UIImage imageNamed:@"some-image.jpg"];
NSData *data = UIImageJPEGRepresentation(image, 0.8f);

PKTAsyncTask *uploadTask = [PKTFile uploadWithData:data fileName:@"image.jpg"];

[uploadTask onComplete:^(PKTFile *file, NSError *error) {
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

[[item save] onComplete:^(PKTResponse *response, NSError *error){
  // Item saved with the file added
}];
{% endhighlight %}

You can also attach a file to any object by supplying its reference type and ID:

{% highlight objective-c %}
PKTFile *file = ...

PKTAsyncTask *attachTask = [file attachWithReferenceID:1234 referenceType:PKTReferenceTypeItem];

[attachTask onComplete:^(PKTResponse *response, NSError *error) {
  if (!error) {
    // File successfully attached to item with ID 1234
  }
}];
{% endhighlight %}