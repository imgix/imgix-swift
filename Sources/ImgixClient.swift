//
//  ImgixClient.swift
//  imgix-swift
//
//  Created by Paul Straw on 6/30/16.
//
//

import Foundation

@objc open class ImgixClient: NSObject {
    static open let VERSION = "0.1.4"

    open let host: String
    open var useHttps: Bool = true
    open var secureUrlToken: String? = nil
    open var includeLibraryParam: Bool = true

    public init(host: String) {
        self.host = host
    }

    public init(host: String, useHttps: Bool) {
        self.host = host
        self.useHttps = useHttps
    }

    public init(host: String, useHttps: Bool, secureUrlToken: String) {
        self.host = host
        self.useHttps = useHttps
        self.secureUrlToken = secureUrlToken
    }

    public init(host: String, secureUrlToken: String) {
        self.host = host
        self.secureUrlToken = secureUrlToken
    }

    open func buildUrl(_ path: String, params: NSDictionary) -> URL {
        let path = sanitizePath(path)

        var urlComponents = URLComponents.init()
        urlComponents.scheme = useHttps ? "https" : "http"
        urlComponents.host = self.host
        urlComponents.percentEncodedPath = path
        urlComponents.queryItems = buildParams(params)

        if secureUrlToken != nil {
            let signature = signatureForPathAndQueryString(path, queryString: encodeQueryItems(urlComponents.queryItems!))
            urlComponents.queryItems?.append(signature)
        }

        if urlComponents.queryItems!.isEmpty {
            urlComponents.queryItems = nil
        } else {
            urlComponents.percentEncodedQuery = encodeQueryItems(urlComponents.queryItems!)
        }

        return urlComponents.url!
    }

    open func buildUrl(_ path: String) -> URL {
        return buildUrl(path, params: NSDictionary())
    }

    fileprivate func sanitizePath(_ path: String) -> String {
        var path = path

        if path.hasPrefix("http://") || path.hasPrefix("https://") {
            path = path.ixEncodeUriComponent()
        }

        if !path.hasPrefix("/") {
            path = "/" + path
        }

        return path
    }

    fileprivate func encodeQueryItems(_ queryItems: [URLQueryItem]) -> String {
        var queryPairs = [String]()

        for queryItem in queryItems {
            let encodedKey = queryItem.name.ixEncodeUriComponent()
            let encodedVal = queryItem.value!.ixEncodeUriComponent()
            queryPairs.append(encodedKey + "=" + encodedVal)
        }

        return queryPairs.joined(separator: "&")
    }

    fileprivate func buildParams(_ params: NSDictionary) -> [URLQueryItem] {
        let params: NSMutableDictionary = NSMutableDictionary.init(dictionary: params)
        var queryItems = [URLQueryItem]()

        if (includeLibraryParam) {
            params.setValue("swift-" + ImgixClient.VERSION, forKey: "ixlib")
        }

        for (key, val) in params {
            let stringKey = String(describing: key)
            var stringVal = String(describing: val)

            if stringKey.hasSuffix("64") {
                stringVal = stringVal.ixEncode64()
            }

            let queryItem = URLQueryItem.init(name: stringKey, value: stringVal)

            queryItems.append(queryItem)
        }

        return queryItems
    }

    fileprivate func signatureForPathAndQueryString(_ path: String, queryString: String) -> URLQueryItem {
        var signatureBase = secureUrlToken! + path

        if queryString.characters.count > 0 {
            signatureBase += "?" + queryString
        }

        let signature = signatureBase.ixMd5

        return URLQueryItem.init(name: "s", value: signature)
    }
}
