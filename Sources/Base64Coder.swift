//
//  Base64Coder.swift
//  imgix-swift
//
//  Created by Paul Straw on 6/30/16.
//
//

import Foundation

struct Base64Coder {
    static func encode64(str: String) -> String {
        let strData = str.dataUsingEncoding(NSUTF8StringEncoding)
        var str64 = strData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())

        str64 = str64!.stringByReplacingOccurrencesOfString("=", withString: "")
        str64 = str64!.stringByReplacingOccurrencesOfString("/", withString: "_")
        str64 = str64!.stringByReplacingOccurrencesOfString("+", withString: "-")

        return str64!
    }
}
