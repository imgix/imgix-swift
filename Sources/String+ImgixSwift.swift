//
//  String+ImgixSwift.swift
//  imgix-swift
//
//  Created by Paul Straw on 7/7/16.
//
//

import Foundation

extension String {
    static var ixEncodeUriComponentCharSet: NSMutableCharacterSet {
        let cs = NSMutableCharacterSet.alphanumericCharacterSet()
        cs.addCharactersInString("-_.!~*'()")
        
        return cs
    }
    
    func ixEncode64() -> String {
        let strData = self.dataUsingEncoding(NSUTF8StringEncoding)
        
        guard var str64 = strData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions()) else {
            return ""
        }
        
        str64 = str64.stringByReplacingOccurrencesOfString("=", withString: "")
        str64 = str64.stringByReplacingOccurrencesOfString("/", withString: "_")
        str64 = str64.stringByReplacingOccurrencesOfString("+", withString: "-")
        
        return str64
    }
    
    func ixEncodeUriComponent() -> String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(String.ixEncodeUriComponentCharSet)!
    }
}