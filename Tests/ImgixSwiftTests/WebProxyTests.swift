//
//  WebProxyTests.swift
//  ImgixSwiftTests
//

import XCTest
import ImgixSwift

class WebProxyTests: XCTestCase {

    var client: ImgixClient!

    override func setUp() {
        super.setUp()

        client = ImgixClient.init(host: "imgix-library-web-proxy-test-source.imgix.net",
                                  secureUrlToken: "qN5VOqaLGQUFzETO")
        client.includeLibraryParam = false
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFullyQualifiedPath() {
        let generatedUrl = client.buildUrl("http://files.paulstraw.com/pixelpaul.png")
        let expectedUrl = "https://imgix-library-web-proxy-test-source.imgix.net/" +
            "http%3A%2F%2Ffiles.paulstraw.com%2Fpixelpaul.png?s=1c57b8db669c9b265b4dd42f3b2de37a"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testEscapesFullyQualifiedPath() {
        let generatedUrl = client.buildUrl("http://files.paulstraw.com/pixel>paul.png")
        let expectedUrl = "https://imgix-library-web-proxy-test-source.imgix.net/" +
            "http%3A%2F%2Ffiles.paulstraw.com%2Fpixel%3Epaul.png?s=a9bbef784d922914d0a915dc9e218f6f"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testEscapesEncodedPath() {
        let generatedUrl = client.buildUrl("http://files.paulstraw.com/%D8%B3%D8%A7%D9%86%D8%AF%D9%88%DB%8C%DA%86.jpg")
        let expectedUrl = "https://imgix-library-web-proxy-test-source.imgix.net/" +
            "http%3A%2F%2Ffiles.paulstraw.com%2F%25D8%25B3%25D8%25A7%25D9%2586%25D8%25AF%25D9%2588%25DB%258C%25DA%2586.jpg?s=aaecb132495341b884a0d8e35a51ae11"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }
}
