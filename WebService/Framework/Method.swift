import Foundation


/// Enum case of HTTP methods
public enum Method: CustomStringConvertible {
    
    /// GET method
    case get
    
    /// POST method
    case post(Any?)
    
    /// PUT method
    case put(Any?)
    
    /// PATCH method
    case patch(Any?)
    
    /// DELETE method
    case delete
    
    /// CustomStringConvertible of the enum case
    public var description: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }
    
    /// The body of the request method
    public var body: Any? {
        switch self {
        case .post(let model): return model
        case .put(let model): return model
        case .patch(let model): return model
        default: return nil
        }
    }
}
