//
//  UriCoder.swift
//  imgix-swift
//
//  Created by Paul Straw on 6/30/16.
//
//

import Foundation

struct UriCoder {
    static var charSet: NSMutableCharacterSet {
        let cs = NSMutableCharacterSet.alphanumericCharacterSet()
        cs.addCharactersInString("-_.!~*'()")

        return cs
    }

    static func encodeURIComponent(str: String) -> String {
        return str.stringByAddingPercentEncodingWithAllowedCharacters(charSet)!
    }
}
