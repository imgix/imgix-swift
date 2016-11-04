//
//  Dictionary+ImgixSwift.swift
//  imgix-swift
//
//  Created by Paul Straw on 11/3/16.
//
//

import Foundation

extension NSDictionary {
    mutating func merge<K, V>(dict: [K: V]){
        for (k, v) in dict {
            self.updateValue(v as Value, forKey: k as Key)
        }
    }
}
