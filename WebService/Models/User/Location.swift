import Foundation


/// A model describing a location
public struct Location: RequestResponse {
    
    /// The location street
    public let street: String
    
    /// The location city
    public let city: String
    
    /// The location state
    public let state: String
    
    /// The location post code
    public let postcode: String
    
    /// The location time zone
    public let timezone: String
    
    /// MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case street
        case city
        case state
        case postcode
        case timezone
    }
}
