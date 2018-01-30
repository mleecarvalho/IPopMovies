//
//  SearchUtils.swift
//  IPopMovies
//
//  Created by Marcio on 30/01/2018.
//  Copyright © 2018 Marcio. All rights reserved.
//

import Foundation

class SearchUtils {
    
    static func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
}
