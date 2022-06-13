//
//  JSONManager.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

final class JSONManager {
    static let shared = JSONManager()
    private init() {}
    
    //  referenced by https://gist.github.com/norsez/aa3f11c0e875526e5270e7791f3891fb
    func load<T: Decodable>(filename: String) -> [T] {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard let url = urls.first else{
            fatalError("Invalid URL")
        }
        let fileURL = url.appendingPathComponent(filename)
        
        var data = Data()
        do {
            data = try Data(contentsOf: fileURL)
        } catch {
            print("No File at \(fileURL)")
            return []
        }
        
        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            fatalError("Decode Error")
        }
    }
    
    //  referenced by https://gist.github.com/norsez/aa3f11c0e875526e5270e7791f3891fb
    func store<T: Encodable>(data: T, filename: String) {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard let url = urls.first else{
            fatalError("Invalid URL")
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        var jsonData = Data()
        do {
            jsonData = try encoder.encode(data)
        } catch {
            fatalError("Encode Error")
        }
        
        let fileURL = url.appendingPathComponent(filename)
        do {
            try jsonData.write(to: fileURL, options: [.atomicWrite])
        } catch {
            fatalError("File Write Error")
        }
        
    }
    
    //  referenced by https://stackoverflow.com/questions/37947509/swift-how-to-determine-application-folder
    func copyBeverageData() {
        let fileManager = FileManager.default
        let sourceUrl = URL(fileURLWithPath: Bundle.main.bundleURL.absoluteString)
        let destinationUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        do {
            guard let destinationUrl = destinationUrls.first else {
                fatalError("No Url")
            }
            
            try fileManager.copyItem(at: sourceUrl.appendingPathComponent("BeverageData.json"),
                                     to: destinationUrl.appendingPathComponent("BeverageData.json"))
        } catch {
            fatalError("Init Data Error")
        }
    }
}
