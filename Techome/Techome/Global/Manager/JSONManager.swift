//
//  JSONManager.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

class JSONManager{
    //  referenced by https://gist.github.com/norsez/aa3f11c0e875526e5270e7791f3891fb
    static func load<T: Decodable>(filename: String) throws -> [T]? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let url = urls.first {
            let fileURL = url.appendingPathComponent(filename)
            let data = try Data(contentsOf: fileURL)
            
            let result = try JSONDecoder().decode([T].self, from: data)
            return result
        }
        return nil
    }
    
    //  referenced by https://gist.github.com/norsez/aa3f11c0e875526e5270e7791f3891fb
    static func save<T: Encodable>(data: T, filename: String) throws{
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let url = urls.first {
            let fileURL = url.appendingPathComponent(filename)
            let jsonData = try JSONEncoder().encode(data)
            
            try jsonData.write(to: fileURL, options: [.atomicWrite])
        }
    }
}
