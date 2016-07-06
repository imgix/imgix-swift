[![imgix logo](https://assets.imgix.net/imgix-logo-web-2014.pdf?page=2&fm=png&w=150)](https://imgix.com)

# imgix-swift [![Slack Status](http://slack.imgix.com/badge.svg)](http://slack.imgix.com) [![Build Status](https://travis-ci.org/imgix/imgix-swift.svg?branch=master)](https://travis-ci.org/imgix/imgix-swift) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CocoaPods](https://img.shields.io/cocoapods/v/ImgixSwift.svg)](https://cocoapods.org/pods/ImgixSwift)


The official imgix Swift client. Written in Swift, but plays nice with Objective-C codebases, too! 👌

imgix is a real-time image processing service and CDN. It allows you to manipulate images merely by changing their URL parameters. For a full list of URL parameters, please see the [imgix URL API documentation](https://www.imgix.com/docs/reference).

* [Installation](#installation)
* [Usage](#usage)
  * [Swift](#swift)
  * [Objective-C](#objective-c)
* [Advanced Usage](#advanced-usage)
  * [Automatic Signing](#automatic-signing)
  * [What is the `ixlib` param?](#what-is-the-ixlib-param)


<a name="installation"></a>
## Installation

* **[Carthage](https://github.com/carthage/carthage):** `github "imgix/imgix-swift"`
* **[CocoaPods](https://github.com/cocoapods/cocoapods):** `pod "ImgixSwift"`


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

If your project doesn't contain any other Swift code, make sure to set your target's `Build Settings > Build Options > Embedded Content Contains Swift Code` to `YES`.

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


<a name="advanced-usage"></a>
## Advanced Usage

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
