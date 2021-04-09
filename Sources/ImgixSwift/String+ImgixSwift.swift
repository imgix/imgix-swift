//
//  String+ImgixSwift.swift
//  imgix-swift
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

extension String {
    static var ixEncodeUriComponentCharSet: CharacterSet = {
        var charSet = CharacterSet.alphanumerics
        charSet.insert(charactersIn: "-_.!~*'()")
        return charSet
    }()

    static var ixEncodeUriCharSet: CharacterSet = {
        var charSet = CharacterSet.urlPathAllowed
        charSet.remove(charactersIn: "#?:+")
        return charSet
    }()

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
        return self.addingPercentEncoding(withAllowedCharacters: String.ixEncodeUriComponentCharSet)!
    }

    func ixEncodeUri() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: String.ixEncodeUriCharSet)!
    }

    func ixMd5() -> String {
        return MD5(string: self)
    }

    func MD5(string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using: .utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress,
                    let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}
