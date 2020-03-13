//
//  ImgixClient.swift
//  imgix-swift
//

import Foundation

@objc open class ImgixClient: NSObject {
    @objc static public let VERSION = "1.1.1"

    @objc public let host: String
    @objc open var useHttps: Bool = true
    @objc open var secureUrlToken: String?
    @objc open var includeLibraryParam: Bool = true

    @objc public init(host: String) {
        self.host = host
    }

    @objc public init(host: String, useHttps: Bool) {
        self.host = host
        self.useHttps = useHttps
    }

    @objc public init(host: String, useHttps: Bool, secureUrlToken: String) {
        self.host = host
        self.useHttps = useHttps
        self.secureUrlToken = secureUrlToken
    }

    @objc public init(host: String, secureUrlToken: String) {
        self.host = host
        self.secureUrlToken = secureUrlToken
    }

    @objc open func buildUrl(_ path: String, params: NSDictionary) -> URL {
        let path = sanitizePath(path)

        var urlComponents = URLComponents.init()
        urlComponents.scheme = useHttps ? "https" : "http"
        urlComponents.host = self.host
        urlComponents.percentEncodedPath = path
        urlComponents.queryItems = buildParams(params)

        if secureUrlToken != nil {
            let signature = signatureForPathAndQueryString(
                path,
                queryString: encodeQueryItems(urlComponents.queryItems!)
            )
            urlComponents.queryItems?.append(signature)
        }

        if urlComponents.queryItems!.isEmpty {
            urlComponents.queryItems = nil
        } else {
            urlComponents.percentEncodedQuery = encodeQueryItems(urlComponents.queryItems!)
        }

        return urlComponents.url!
    }

    @objc open func buildUrl(_ path: String) -> URL {
        return buildUrl(path, params: NSDictionary())
    }

    @objc open func reconstruct(originalURL: URL, params: NSDictionary) -> URL {
        let originalURLComponents = URLComponents(url: originalURL, resolvingAgainstBaseURL: false)
        let mergedParams = NSMutableDictionary()

        if let originalURLQueryItems = originalURLComponents?.queryItems {
            for queryItem in originalURLQueryItems {
                mergedParams.setValue(queryItem.value, forKey: queryItem.name)
            }
        }

        mergedParams.addEntries(from: params as! [AnyHashable: Any])

        let generatedURL = buildUrl(originalURL.path, params: mergedParams)

        var outputURLComponents = URLComponents(url: generatedURL, resolvingAgainstBaseURL: false)!

        outputURLComponents.host = originalURL.host
        outputURLComponents.scheme = originalURL.scheme
        outputURLComponents.port = originalURL.port

        return outputURLComponents.url!
    }

    @objc open func reconstruct(originalURL: URL) -> URL {
        return reconstruct(originalURL: originalURL, params: [:])
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
        var queryItems = [URLQueryItem]()
        let queryParams: NSMutableDictionary = NSMutableDictionary.init(dictionary: params)

        if includeLibraryParam {
            queryParams.setValue("swift-" + ImgixClient.VERSION, forKey: "ixlib")
        }

        let keys = queryParams.allKeys.map { String(describing: $0) }

        for key in keys.sorted(by: {$0 < $1}) {
            if let val = queryParams[key] {
                var stringVal = String(describing: val)

                if key.hasSuffix("64") {
                    stringVal = stringVal.ixEncode64()
                }

                let queryItem = URLQueryItem.init(name: key, value: stringVal)

                queryItems.append(queryItem)
            }
        }

        return queryItems
    }

    fileprivate func signatureForPathAndQueryString(_ path: String, queryString: String) -> URLQueryItem {
        var signatureBase = secureUrlToken! + path

        if !queryString.isEmpty {
            signatureBase += "?" + queryString
        }

        let signature = signatureBase.ixMd5()

        return URLQueryItem.init(name: "s", value: signature)
    }
}
