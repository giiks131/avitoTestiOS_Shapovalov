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
    

    // Key-value storage for the cache
    private var cache: [String: Any] = [:]

    // Function to add items to the cache
    func set<T: Codable>(key: String, value: T) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    // Function to retrieve items from the cache
    func get<T: Codable>(key: String, type: T.Type) -> T? {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode(type, from: data) {
            return decoded
        }
        return nil
    }

    // Function to remove items from the cache
    func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }

    // Function to cache image
    func setImage(key: String, image: UIImage) {
        if let data = image.pngData() {
            let url = getDocumentsDirectory().appendingPathComponent(key)
            try? data.write(to: url)
        }
    }

    // Function to retrieve cached image
    func getImage(key: String) -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(key)
        if let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }

    // Helper function to get the documents directory
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
