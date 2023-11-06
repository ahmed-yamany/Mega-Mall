//
//  UserDefaults.swift
//
//  Created by Ahmed Yamany on 29/10/2023.
//

import Foundation

open class UserDefaultsKeys {
    static let shared = UserDefaultsKeys()
    private init() { }
}

// Property wrapper for UserDefaults
@propertyWrapper
public struct UserDefault<T: Codable> {
    let key: String
    public init(key: KeyPath<UserDefaultsKeys, String>) {
        self.key = UserDefaultsKeys.shared[keyPath: key]
    }
    public var wrappedValue: T? {
        get {
            return UserDefaults.standard.load(object: T.self, fromKey: key)
        }
        set {
            UserDefaults.standard.save(customObject: newValue, inKey: key)
        }
    }
}
//
public extension UserDefaults {
    /// Saves a Codable object into UserDefaults with the specified key.
    /// - Parameters:
    ///   - object: The Codable object to be saved.
    ///   - key: The key under which to store the object in UserDefaults.
    func save(customObject object: some Encodable, inKey key: String) {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(object) else {
            return
        }
        self.set(encoded, forKey: key)
    }
    /// Loads a Codable object from UserDefaults for the specified key.
    /// - Parameters:
    ///   - type: The type of the object to decode.
    ///   - key: The key used to retrieve the object from UserDefaults.
    /// - Returns: The decoded object of the specified type, or nil if decoding fails.
    func load<T: Decodable>(object type: T.Type, fromKey key: String) -> T? {
        if let data = self.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                return object
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    /// Resets UserDefaults keys associated with the specified array of keys.
    /// - Parameters:
    ///   - keys: An array of keys to reset in UserDefaults.
    ///   - completion: A completion closure to be executed after resetting the keys.
    func reset(keys: [String], _ completion: @escaping () -> Void) {
        keys.forEach { removeObject(forKey: $0) }
        completion()
    }
}
