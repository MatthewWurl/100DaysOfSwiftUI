//
//  FileManager-DocumentsDirectory.swift
//  HotProspects
//
//  Created by Matt X on 3/17/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
