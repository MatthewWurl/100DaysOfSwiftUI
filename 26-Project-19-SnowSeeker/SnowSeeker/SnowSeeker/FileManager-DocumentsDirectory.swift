//
//  FileManager-DocumentsDirectory.swift
//  SnowSeeker
//
//  Created by Matt X on 4/1/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
