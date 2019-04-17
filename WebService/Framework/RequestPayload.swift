import Foundation


/// A protocol to build request payloads
public protocol RequestPayload {
    
    /// The request payload
    var body: Data { get }
}


extension RequestPayload where Self: Encodable {
    public var body: Data {
        return try! JSONEncoder().encode(self)
    }
}

