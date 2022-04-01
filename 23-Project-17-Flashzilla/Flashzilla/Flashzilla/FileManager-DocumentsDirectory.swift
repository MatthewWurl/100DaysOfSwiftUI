//
//  FileManager-DocumentsDirectory.swift
//  Flashzilla
//
//  Created by Matt X on 3/24/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
