//
//  String+ImgixSwift.swift
//  imgix-swift
//
//  Created by Paul Straw on 7/7/16.
//
//

import Foundation
import CommonCrypto

extension String {
    static var ixEncodeUriComponentCharSet: NSMutableCharacterSet {
        let cs = NSMutableCharacterSet.alphanumeric()
        cs.addCharacters(in: "-_.!~*'()")
        
        return cs
    }
    
    func ixEncode64() -> String {
        let strData = self.data(using: String.Encoding.utf8)
        
        guard var str64 = strData?.base64EncodedString(options: Data.Base64EncodingOptions()) else {
            return ""
        }
        
        str64 = str64.replacingOccurrences(of: "=", with: "")
        str64 = str64.replacingOccurrences(of: "/", with: "_")
        str64 = str64.replacingOccurrences(of: "+", with: "-")
        
        return str64
    }
    
    func ixEncodeUriComponent() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: String.ixEncodeUriComponentCharSet as CharacterSet)!
    }

    func ixMd5() -> String {
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }

        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }

}

