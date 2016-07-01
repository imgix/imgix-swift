//
//  ImgixClient.swift
//  imgix-swift
//
//  Created by Paul Straw on 6/30/16.
//
//

import Foundation

public class ImgixClient {
    let host: String
    var useHttps: Bool = true
    var secureUrlToken: String? = nil
    var includeLibraryParam: Bool = true
    
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
    
    public func buildUrl(path: String, params: [String: AnyObject]) -> NSURL {
        let path = sanitizePath(path)
        
        let queryParams: String
        
        if secureUrlToken != nil {
            queryParams = signParams(path, queryString: buildParams(params))
        } else {
            queryParams = buildParams(params)
        }
        
        let urlPrefix = useHttps ? "https://" : "http://"
        let urlString = urlPrefix + host + path + queryParams
        
        return NSURL.init(string: urlString)!
    }
    
    public func buildUrl(path: String) -> NSURL {
        return buildUrl(path, params: [String: AnyObject]())
    }
    
    private func sanitizePath(path: String) -> String {
        var path = path
        
        if path.hasPrefix("http://") || path.hasPrefix("https://") {
            path = UriCoder.encodeURIComponent(path)
        }
        
        if !path.hasPrefix("/") {
            path = "/" + path
        }
        
        return path
    }
    
    private func buildParams(params: [String: AnyObject]) -> String {
        var params = params
        var queryParams = [String]()
        
        if (includeLibraryParam) {
            params["ixlib"] = "swift-".stringByAppendingString(NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as! String)
        }
        
        for (key, val) in params {
            let encodedKey = UriCoder.encodeURIComponent(key)
            let encodedVal: String
            
            if key.hasSuffix("64") {
                encodedVal = Base64Coder.encode64(String(val))
            } else {
                encodedVal = UriCoder.encodeURIComponent(String(val))
            }
            
            queryParams.append(encodedKey + "=" + encodedVal)
        }
        
        if queryParams.count > 0 {
            queryParams[0] = "?" + queryParams[0]
        }
        
        return queryParams.joinWithSeparator("&")
    }
    
    private func signParams(path: String, queryString: String) -> String {
        let signatureBase = secureUrlToken! + path + queryString
        let signature = signatureBase.md5
        
        if queryString.characters.count > 0 {
            return queryString + "&s=" + signature
        } else {
            return queryString + "?s=" + signature
        }
    }
}