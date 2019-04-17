import Foundation


/// The User route
public enum UserRoute: Route {
    
    /// GET user list
    case list
    
    /// GET user profile
    case user(id: Int)
    
    public var description: (url: String, method: Method) {
        switch self {
        case .list: return ("\(host)/user", .get)
        case .user(let id): return ("\(host)/user/\(id)", .get)
        }
    }
}
