//
//  BuildUrlTests.swift
//  ImgixSwiftTests
//

import XCTest
import ImgixSwift

class BuildUrlTests: XCTestCase {
    var client: ImgixClient!

    override func setUp() {
        super.setUp()

        client = ImgixClient.init(host: "paulstraw.imgix.net")
        client.includeLibraryParam = false
    }

    override func tearDown() {
        super.tearDown()
    }

    func testBuildUrlWithoutParams() {
        let generatedUrl = client.buildUrl("1.jpg")
        let expectedUrl = "https://paulstraw.imgix.net/1.jpg"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testBuildUrlWithoutParamsAndIncludeLibraryParam() {
        client.includeLibraryParam = true

        let generatedUrl = client.buildUrl("1.jpg")
        let expectedUrl = "https://paulstraw.imgix.net/1.jpg?ixlib=swift-\(ImgixClient.VERSION)"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testBuildUrlEmptyParams() {
        let generatedUrl = client.buildUrl("1.jpg", params: [:])
        let expectedUrl = "https://paulstraw.imgix.net/1.jpg"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testBuildUrlWithOneParam() {
        let generatedUrl = client.buildUrl("1.jpg", params: ["w": 400])
        let expectedUrl = "https://paulstraw.imgix.net/1.jpg?w=400"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testBuildUrlWithOneParamAndIncludeLibraryParam() {
        client.includeLibraryParam = true

        let generatedUrl = client.buildUrl("1.jpg", params: ["w": 400])
        let expectedUrl = "https://paulstraw.imgix.net/1.jpg?ixlib=swift-\(ImgixClient.VERSION)&w=400"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testBuildUrlWithMultipleParams() {
        let generatedUrl = client.buildUrl("1.jpg", params: ["w": 400, "flip": "v"])
        let expectedUrl = "https://paulstraw.imgix.net/1.jpg?flip=v&w=400"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testBuildUrlWithMultipleParamsSorted() {
        let generatedUrl = client.buildUrl("1.jpg", params: ["w": 900, "h": 300, "fit": "crop", "crop": "entropy"])
        let expectedUrl = "https://paulstraw.imgix.net/1.jpg?crop=entropy&fit=crop&h=300&w=900"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testBuildUrlWithMultipleParamsAndIncludeLibraryParamSorted() {
        client.includeLibraryParam = true
        let generatedUrl = client.buildUrl("1.jpg", params: ["w": 900, "h": 300, "fit": "crop", "crop": "entropy"])
        let expectedUrl = "https://paulstraw.imgix.net/1.jpg?" +
            "crop=entropy&fit=crop&h=300&ixlib=swift-\(ImgixClient.VERSION)&w=900"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testQueryStringKeyEscaping() {
        let generatedUrl = client.buildUrl("1.jpg", params: ["hello world": "interesting"])
        let expectedQuery = "hello%20world=interesting"

        XCTAssert(generatedUrl.query == expectedQuery)
    }

    func testQueryStringValueEscaping() {
        let generatedUrl = client.buildUrl("1.jpg", params: ["txt": "/foo'> <script>alert('hacked')</script><"])
        let expectedQuery = "txt=%2Ffoo'%3E%20%3Cscript%3Ealert('hacked')%3C%2Fscript%3E%3C"

        XCTAssert(generatedUrl.query == expectedQuery)
    }

    func testBase64ParamVariantsAreBase64Encoded() {
        let generatedUrl = client.buildUrl("~text", params: ["txt64": "I cannøt belîév∑ it wors! 😱"])
        let expectedQuery = "txt64=SSBjYW5uw7h0IGJlbMOuw6l24oiRIGl0IHdvcu-jv3MhIPCfmLE"

        XCTAssert(generatedUrl.query == expectedQuery)
    }

    func testUriEncodePath() {
        let generatedUrl = client.buildUrl("ساندویچ.jpg", params: [:])
        let expectedUrl = "https://paulstraw.imgix.net/%D8%B3%D8%A7%D9%86%D8%AF%D9%88%DB%8C%DA%86.jpg"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testIgnoresLeadingSlash() {
        let generatedUrl = client.buildUrl("/image.jpg", params: [:])
        let expectedUrl = "https://paulstraw.imgix.net/image.jpg"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testEncodesReservedCharacters() {
        let generatedUrl = client.buildUrl("&$+,:;=?@#.jpg", params: [:])
        let expectedUrl = "https://paulstraw.imgix.net/&$%2B,%3A%3B=%3F@%23.jpg"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testEncodesUnsafeCharacters() {
        let generatedUrl = client.buildUrl(" <>[]{}|^%\\.jpg", params: [:])
        let expectedUrl = "https://paulstraw.imgix.net/%20%3C%3E%5B%5D%7B%7D%7C%5E%25%5C.jpg"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testEncodesUnicode() {
        let generatedUrl = client.buildUrl("/example/I cannøt belîév∑ it wors! 😱.jpg", params: [:])
        let expectedUrl = "https://paulstraw.imgix.net/example/I%20cann%C3%B8t%20bel%C3%AE%C3%A9v%E2%88%91%20it%20wor%EF%A3%BFs!%20%F0%9F%98%B1.jpg"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testDoesNotEncodeValidPathCharacters() {
        let generatedUrl = client.buildUrl("images/sub_directory-3/date,12.2020/bluehat.jpg", params: [:])
        let expectedUrl = "https://paulstraw.imgix.net/images/sub_directory-3/date,12.2020/bluehat.jpg"

        print(generatedUrl)
        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }
}
