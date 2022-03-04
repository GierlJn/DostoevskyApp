//
//  Bundle+Ext.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 02.03.22.
//

import Foundation

extension Bundle{
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil)else {
            fatalError("failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load \(file) in bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            
            fatalError("failed to decode \(file) in bundle")
        }
        return loaded
    }
}

