//
//  ReconstructTests.swift
//  ImgixSwiftTests
//

import XCTest
import ImgixSwift

class ReconstructTests: XCTestCase {
    var client: ImgixClient!

    override func setUp() {
        super.setUp()

        client = ImgixClient.init(host: "paulstraw.imgix.net")
        client.includeLibraryParam = false
    }

    override func tearDown() {
        super.tearDown()
    }

    func testReconstructUrlWithoutParams() {
        let inputUrl = NSURL.init(string: "https://paulstraw.imgix.net/pika.jpg")
        let generatedUrl = client.reconstruct(originalURL: inputUrl! as URL)
        let expectedUrl = "https://paulstraw.imgix.net/pika.jpg"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testReconstructUrlWithSingleExistingParam() {
        let inputUrl = NSURL.init(string: "https://paulstraw.imgix.net/pika.jpg?w=200")
        let generatedUrl = client.reconstruct(originalURL: inputUrl! as URL)
        let expectedUrl = "https://paulstraw.imgix.net/pika.jpg?w=200"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testReconstructUrlWithMultipleExistingParams() {
        let inputUrl = NSURL.init(string: "https://paulstraw.imgix.net/pika.jpg?w=200&h=200")
        let generatedUrl = client.reconstruct(originalURL: inputUrl! as URL)
        let expectedUrl = "https://paulstraw.imgix.net/pika.jpg?h=200&w=200"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testReconstructUrlWithoutParamsAndOneNewParam() {
        let inputUrl = NSURL.init(string: "https://paulstraw.imgix.net/pika.jpg")
        let generatedUrl = client.reconstruct(originalURL: inputUrl! as URL, params: ["w": 200])
        let expectedUrl = "https://paulstraw.imgix.net/pika.jpg?w=200"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testReconstructUrlWithoutParamsAndMultipleNewParams() {
        let inputUrl = NSURL.init(string: "https://paulstraw.imgix.net/pika.jpg")
        let generatedUrl = client.reconstruct(originalURL: inputUrl! as URL, params: ["w": 200, "h": 200])
        let expectedUrl = "https://paulstraw.imgix.net/pika.jpg?h=200&w=200"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testReconstructUrlWithSingleExistingParamAndOneNewParam() {
        let inputUrl = NSURL.init(string: "https://paulstraw.imgix.net/pika.jpg?w=200")
        let generatedUrl = client.reconstruct(originalURL: inputUrl! as URL, params: ["h": 200])
        let expectedUrl = "https://paulstraw.imgix.net/pika.jpg?h=200&w=200"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testReconstructUrlWithMultipleExistingParamsAndOneNewParam() {
        let inputUrl = NSURL.init(string: "https://paulstraw.imgix.net/pika.jpg?w=200&h=200")
        let generatedUrl = client.reconstruct(originalURL: inputUrl! as URL, params: ["fit": "crop"])
        let expectedUrl = "https://paulstraw.imgix.net/pika.jpg?fit=crop&h=200&w=200"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testReconstructUrlWithMultipleExistingParamsAndMultipleNewParams() {
        let inputUrl = NSURL.init(string: "https://paulstraw.imgix.net/pika.jpg?w=200&h=200")
        let generatedUrl = client.reconstruct(originalURL: inputUrl! as URL, params: ["fit": "crop", "invert": true])
        let expectedUrl = "https://paulstraw.imgix.net/pika.jpg?fit=crop&h=200&invert=1&w=200"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testReconstructUrlWithExistingParamOverriddenByNewParam() {
        let inputUrl = NSURL.init(string: "https://paulstraw.imgix.net/pika.jpg?w=200")
        let generatedUrl = client.reconstruct(originalURL: inputUrl! as URL, params: ["w": 300])
        let expectedUrl = "https://paulstraw.imgix.net/pika.jpg?w=300"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testReconstructUrlWithDifferentHostThanClient() {
        let inputUrl = NSURL.init(string: "https://faulstraw.imgix.net/pika.jpg")
        let generatedUrl = client.reconstruct(originalURL: inputUrl! as URL)
        let expectedUrl = "https://faulstraw.imgix.net/pika.jpg"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testReconstructUrlWithDifferentSchemeThanClient() {
        let inputUrl = NSURL.init(string: "http://paulstraw.imgix.net/pika.jpg")
        let generatedUrl = client.reconstruct(originalURL: inputUrl! as URL)
        let expectedUrl = "http://paulstraw.imgix.net/pika.jpg"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }

    func testReconstructUrlWithDifferentPortThanClient() {
        let inputUrl = NSURL.init(string: "https://paulstraw.imgix.net:8080/pika.jpg")
        let generatedUrl = client.reconstruct(originalURL: inputUrl! as URL)
        let expectedUrl = "https://paulstraw.imgix.net:8080/pika.jpg"

        XCTAssert(generatedUrl.absoluteString == expectedUrl)
    }
}
