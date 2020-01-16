<!-- ix-docs-ignore -->
![imgix logo](https://assets.imgix.net/sdk-imgix-logo.svg)

`imgix-swift` is a client library for generating image URLs with [imgix](https://www.imgix.com/). Written in Swift, but can be used with Objective-C codebases as well.

[![CocoaPods](https://img.shields.io/cocoapods/v/ImgixSwift.svg)](https://cocoapods.org/pods/ImgixSwift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/imgix/imgix-swift.svg?branch=master)](https://travis-ci.org/imgix/imgix-swift)
[![License](https://img.shields.io/github/license/imgix/imgix-swift)](https://github.com/imgix/imgix-swift/blob/master/LICENSE.md)

---
<!-- /ix-docs-ignore -->

* [Installation](#installation)
* [Usage](#usage)
  * [Swift](#swift)
  * [Objective-C](#objective-c)
* [Advanced Usage](#advanced-usage)
  * [Automatic Signing](#automatic-signing)
  * [Automatic Base64 Encoding](#automatic-base64-encoding)
  * [URL Reconstruction](#url-reconstruction)
  * [What is the `ixlib` param?](#what-is-the-ixlib-param)

<a name="installation"></a>
## Installation

* **[Carthage](https://github.com/carthage/carthage):** `github "imgix/imgix-swift"`
* **[CocoaPods](https://github.com/cocoapods/cocoapods):** `pod "ImgixSwift"`


<a name="usage"></a>
## Usage

<a name="swift"></a>
### Swift

The imgix Swift client is compatible with Swift 4.0.

The lastest version compatible with Swift 3.0 is [`0.3.0`](https://github.com/imgix/imgix-swift/releases/tag/0.3.0).

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
]) // => https://assets.imgix.net/dog.jpg?fit=crop&h=300&w=300
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
}]; // => https://assets.imgix.net/dog.jpg?fit=crop&h=300&w=300
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

<a name="automatic-base64-encoding"></a>
### Automatic Base64 Encoding

imgix-swift will automatically Base64-encode any parameter key ending in `64`, according to the requirements of imgix's [Base64 variant parameters](https://docs.imgix.com/apis/url#base64-variants).

``` swift
let client = ImgixClient.init(host: "assets.imgix.net")

client.buildUrl("dog.jpg", params: [
  "w": 640,
  "txt64": "🐶 Puppy!",
  "txtfont64": "Avenir Next Demi,Bold",
  "txtalign": "center,top",
  "txtpad": 50,
  "txtshad": 10,
  "txtclr": "fff",
  "txtfit": "max",
  "txtsize": 50
]) // => https://assets.imgix.net/dog.jpg?txt64=8J-QtiBQdXBweSE&txtalign=center%2Ctop&txtclr=fff&txtfit=max&txtfont64=QXZlbmlyIE5leHQgRGVtaSxCb2xk&txtpad=50&txtshad=10&txtsize=50&w=640
```

<a name="url-reconstruction"></a>
### URL Reconstruction

You can reconstruct existing URLs by using the `ImgixClient#reconstruct` method. Existing parameters on the input URL will be merged and/or overridden by passed params.

``` swift
let client = ImgixClient.init(host: "assets.imgix.net")
let inputUrl = URL.init(string: "https://paulstraw.imgix.net/pika.jpg?w=300")!

client.reconstruct(originalURL: inputUrl, params: [
  "h": 300,
  "fit": "crop"
]) // => https://paulstraw.imgix.net/pika.jpg?fit=crop&h=300&w=300
```


<a name="what-is-the-ixlib-param"></a>
### What is the `ixlib` param?

For security and diagnostic purposes, we default to signing all requests with the language and version of library used to generate the URL. This can be disabled by setting `client.includeLibraryParam = false`.
