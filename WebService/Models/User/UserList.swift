import Foundation


/// A model for the user list resource
public struct UserList: RequestResponse {
    
    /// An array of users
    public let data: [User]
    
    /// MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
