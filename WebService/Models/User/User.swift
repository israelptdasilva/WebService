import Foundation


/// The user resource model
public struct User: RequestResponse {
    
    /// The user resource identifier
    public let id: Int
    
    /// The user name
    public let firstName: String
    
    /// The user last name
    public let lastName: String
    
    /// The user image url
    public let image: String
    
    /// The user gender
    public let gender: String?
    
    /// The user location
    public let location: Location?
    
    /// MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case image
        case gender
        case location
    }
}
