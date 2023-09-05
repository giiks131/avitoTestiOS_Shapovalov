//
//  CacheManager.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 04/09/23.
//

import UIKit

class CacheManager {
    
    static let shared = CacheManager()
    private init() {}
    
    private var cache: [String: Any] = [:]
    private let cacheQueue = DispatchQueue(label: "com.avitoTestiOS_Shapovalov.CacheQueue")
    
    func set<T: Codable>(key: String, value: T) {
        cacheQueue.async {
            let encoder = JSONEncoder()
            do {
                let encoded = try encoder.encode(value)
                UserDefaults.standard.set(encoded, forKey: key)
            } catch {
                // Handle error
            }
        }
    }
    
    func get<T: Codable>(key: String, type: T.Type) -> T? {
        return cacheQueue.sync {
            if let data = UserDefaults.standard.data(forKey: key) {
                do {
                    let decoded = try JSONDecoder().decode(type, from: data)
                    return decoded
                } catch {
                    // Handle error
                    return nil
                }
            }
            return nil
        }
    }
    
    func setImage(key: String, image: UIImage) {
        cacheQueue.async {
            let safeKey = key.replacingOccurrences(of: "/", with: "_")
            if let data = image.pngData() {
                let url = self.getDocumentsDirectory().appendingPathComponent(safeKey)
                do {
                    try data.write(to: url)
                } catch {
                    // Handle error
                }
            }
        }
    }
    
    func getImage(key: String) -> UIImage? {
        return cacheQueue.sync {
            let safeKey = key.replacingOccurrences(of: "/", with: "_")
            let url = self.getDocumentsDirectory().appendingPathComponent(safeKey)
            do {
                let data = try Data(contentsOf: url)
                return UIImage(data: data)
            } catch {
                // Handle error
                return nil
            }
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
