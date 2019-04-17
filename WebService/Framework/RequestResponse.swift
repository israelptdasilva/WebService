import Foundation


/// RequestResponse able to be serialized from Data
public protocol RequestResponse: Decodable {
    
    /// Serializes Data to Self
    ///
    /// - parameter data: Data to serialize
    /// - returns: Self where Self is Decodable
    static func deserialize(_ data: Data) -> Self
}


public extension RequestResponse {
    static func deserialize(_ data: Data) -> Self {
        return try! JSONDecoder().decode(Self.self, from: data)
    }
}
