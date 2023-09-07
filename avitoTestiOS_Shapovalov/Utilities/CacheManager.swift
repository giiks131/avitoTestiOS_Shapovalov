//
//  CacheManager.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 04/09/23.
//

import UIKit

/// Singleton class for managing cache operations.
/// - Provides functionality to set and get Codable objects.
/// - Provides functionality to set and get UIImages.
class CacheManager {
    
    /// Shared instance for singleton implementation.
    static let shared = CacheManager()
    
    /// Private initializer for singleton pattern.
    private init() {}
    
    /// DispatchQueue to handle cache operations asynchronously.
    private let cacheQueue = DispatchQueue(label: "com.avitoTestiOS_Shapovalov.CacheQueue")
    
    /// Store a Codable object in UserDefaults.
    /// - Parameters:
    ///   - key: The key to associate the object with.
    ///   - value: The Codable object to store.
    func set<T: Codable>(key: String, value: T) {
        cacheQueue.async {
            let encoder = JSONEncoder()
            do {
                let encoded = try encoder.encode(value)
                UserDefaults.standard.set(encoded, forKey: key)
            } catch let error {
                print("Cache Error: Failed to encode \(error.localizedDescription)")
            }
        }
    }
    
    /// Retrieve a Codable object from UserDefaults.
    /// - Parameters:
    ///   - key: The key associated with the object.
    ///   - type: The type of the Codable object.
    /// - Returns: The retrieved object or nil if not found.
    func get<T: Codable>(key: String, type: T.Type) -> T? {
        return cacheQueue.sync {
            if let data = UserDefaults.standard.data(forKey: key) {
                do {
                    let decoded = try JSONDecoder().decode(type, from: data)
                    return decoded
                } catch let error {
                    print("Cache Error: Failed to decode \(error.localizedDescription)")
                    return nil
                }
            }
            return nil
        }
    }
    
    /// Store an image on disk.
    /// - Parameters:
    ///   - key: The key to associate the image with.
    ///   - image: The UIImage to store.
    func setImage(key: String, image: UIImage) {
        cacheQueue.async {
            let safeKey = key.replacingOccurrences(of: "/", with: "_")
            if let data = image.pngData() {
                let url = self.getDocumentsDirectory().appendingPathComponent(safeKey)
                do {
                    try data.write(to: url)
                } catch let error {
                    print("Cache Error: Failed to write image \(error.localizedDescription)")
                }
            }
        }
    }
    
    /// Retrieve an image from disk.
    /// - Parameters:
    ///   - key: The key associated with the image.
    /// - Returns: The retrieved UIImage or nil if not found.
    func getImage(key: String) -> UIImage? {
        return cacheQueue.sync {
            let safeKey = key.replacingOccurrences(of: "/", with: "_")
            let url = self.getDocumentsDirectory().appendingPathComponent(safeKey)
            do {
                let data = try Data(contentsOf: url)
                return UIImage(data: data)
            } catch let error {
                // error
                return nil
            }
        }
    }
    
    /// Returns the document directory URL.
    /// - Returns: The URL to the documents directory.
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
