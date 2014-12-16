---
layout: default
---
# Release Notes

## [2.0](https://github.com/podio/podio-objc/releases/tag/2.0.0)
* New `PKTPushClient` for subscribing to real-time updates. This is included as a subpod of the main PodioKit pod, and needs to be explicitly included in your Podfile.
* `PKTDatastore` for optionally storing data locally.
* Optional support for SSL pinning of .cer files included in the bundle.
* Lat/long support for item location fields
* Conversations API area support.
* Notifications API area support.
* Search API area support.
* Reference search support.
* New request to create and embed.
* New request for adding an app to a workspace.
* Better documentation of core classes.

## [Beta 6](https://github.com/podio/podio-objc/releases/tag/2.0.0-beta6)
* Fixes issue where the OAuth token was not refreshed properly due a bug introduced with the introduction of `PKTAsyncTask`.
* Added `then:` combinator method to `PKTAsyncTask` to add ordered side effects to the completion of a task.
* Ability to create workspaces
* Support for workspace member management
* Ability to delete tasks

## [Beta 5](https://github.com/podio/podio-objc/releases/tag/2.0.0-beta5)
* Replaces the use of trailing completion handler blocks for handling result of asynchronous methods with a future-like
`PKTAsyncTask` class.

## [Beta 4](https://github.com/podio/podio-objc/releases/tag/2.0.0-beta4)
* Removed dependency on AFNetworking. PodioKit now uses the NSURLSession API for networking.

## [Beta 3](https://github.com/podio/podio-objc/releases/tag/2.0.0-beta3)
* General fixes and improvements

## [Beta 2](https://github.com/podio/podio-objc/releases/tag/2.0.0-beta2)
* Improved item field handling, including native types for field values, e.g. PKTDuration, PKTDateRange, PKTMoney etc.
* Improved error messages on wrong usage
* Organizations and workspaces API
* Calendar event API
* General fixes and improvements

## [Beta 1](https://github.com/podio/podio-objc/releases/tag/2.0.0-beta1)
* Initial beta release.