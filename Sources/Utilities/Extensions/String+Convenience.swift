//
//  String+Convenience.swift
//  interface-analyser
//
//  Created by Ilias Pavlidakis on 28/2/25.
//

import Foundation


extension String {
    var fileContents: String? {
        guard
            let data = FileManager.default.contents(atPath: self),
            let result = String(data: data, encoding: .utf8)
        else {
            return nil
        }
        return result
    }
}
