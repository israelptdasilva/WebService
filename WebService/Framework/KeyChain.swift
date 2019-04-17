import Security
import Foundation


/// Save and load a value in the key chain
public struct KeyChain {
    
    /// A list of cases to use when saving values to the Keychain
    public enum Key: String {
        
        /// A key to save a token to the Keychain
        case token = "token"
    }
    
    /// Saves a key-value pair to the Keychain
    ///
    /// - Parameters:
    ///   - key: A Key case to save the value with
    ///   - value: The value to be save in the Keychain
    public static func save(key: Key, value: String) {
        let encoded = value.data(using: String.Encoding.utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: encoded
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    /// Loads a value from the Keychain
    ///
    /// - Parameter key: The Key case used when saving the value to the Keychain
    /// - Returns: The value previously saved to the Keychain
    public static func load(key: Key) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        guard SecItemCopyMatching(query as CFDictionary, &item) == noErr else { return nil }
        guard let data = item as? Data else { return nil }
        
        let value = String(data: data, encoding: .utf8)
        return value
    }
    
    /// Deletes a value from the Keychain
    ///
    /// - Parameter key: The Key case used when saving the value to the Keychain
    public static func delete(key: Key) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
