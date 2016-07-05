[![imgix logo](https://assets.imgix.net/imgix-logo-web-2014.pdf?page=2&fm=png&w=150)](https://imgix.com)

# imgix-swift [![Build Status](https://travis-ci.org/imgix/imgix-swift.svg?branch=master)](https://travis-ci.org/imgix/imgix-swift) [![Slack Status](http://slack.imgix.com/badge.svg)](http://slack.imgix.com)

The official imgix Swift client. Also plays nicely with Objective-C projects!

imgix is a real-time image processing service and CDN. It allows you to manipulate images merely by changing their URL parameters. For a full list of URL parameters, please see the [imgix URL API documentation](https://www.imgix.com/docs/reference).

* [Usage](#usage)
  * [Swift](#swift)
  * [Objective-C](#objective-c)
  * [Automatic Signing](#automatic-signing)
  * [What is the `ixlib` param?](#what-is-the-ixlib-param)


<a name="usage"></a>
## Usage

<a name="swift"></a>
### Swift

``` swift
// Import the framework
import ImgixSwift

// Set up an ImgixClient
let client = ImgixClient.init(host: "assets.imgix.net")

// Build a basic URL
client.buildUrl("dog.jpg") // => https://assets.imgix.net/dog.jpg

// Add some parameters
client.buildUrl("dog.jpg", params: [
  "w": 300,
  "h": 300,
  "fit": "crop"
]) // => https://assets.imgix.net/dog.jpg?w=300&h=300&fit=crop
```

<a name="objective-c"></a>
### Objective-C

``` objective-c
// Import the framework
#import <ImgixSwift/ImgixSwift.h>

// Set up an ImgixClient
ImgixClient *client = [[ImgixClient alloc] initWithHost:@"assets.imgix.net"];

// Build a basic URL
[client buildUrl:@"dog.jpg"]; // => https://assets.imgix.net/dog.jpg

// Add some parameters
[client buildUrl:@"dog.jpg", params:@{
  @"w": @300,
  @"h": @300,
  @"fit": @"crop",
}]; // => https://assets.imgix.net/dog.jpg?w=300&h=300&fit=crop
```

<a name="automatic-signing"></a>
### Automatic Signing

If you're using a source that requires signed URLs, imgix-swift can automatically build and sign them for you.

``` swift
let signedClient = ImgixClient.init(
  host: "imgix-library-secure-test-source.imgix.net",
  secureUrlToken: "EHFQXiZhxP4wA2c4"
)

signedClient.buildUrl("dog.jpg", params: [
  "bri": 50
]) // => https://imgix-library-secure-test-source.imgix.net/dog.jpg?bri=50&s=3b293930d9c288fb788657fd9ed8164f
```

<a name="what-is-the-ixlib-param"></a>
### What is the `ixlib` param?

For security and diagnostic purposes, we default to signing all requests with the language and version of library used to generate the URL. This can be disabled by setting `client.includeLibraryParam = false`.
