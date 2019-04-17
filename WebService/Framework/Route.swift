import Foundation


/// Use this protocol to describe a remote resource
public protocol Route {
    
    /// A tuple with url and method to access the resource
    var description: (url: String, method: Method) { get }
    
    /// The route host url
    var host: String { get }
}


public extension Route {
    
    /// The resource host URL
    var host: String {
        return "https://dummyapi.io/api"
    }
}
