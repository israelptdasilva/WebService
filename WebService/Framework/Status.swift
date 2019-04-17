import Foundation


/// A convenience enum describes http status codes in human-friendly format
enum Status: Int {
    
    /// JSONRequest completed successfully
    case ok = 200
    
    /// JSONRequest created a new record in the remote storage
    case created = 201
    
    /// A record could not be found
    case notFound = 404
    
    /// The request could not be processed
    case unprocessable = 402
    
    /// Login is required to perform this request
    case unauthorized = 401
    
    /// Server was unable to process the request
    case badRequest = 400
}


extension HTTPURLResponse {
    
    /// A conversion of the HTTP status code to Status enum
    var status: Status {
        guard let status = Status(rawValue: statusCode) else { return .unprocessable }
        return status
    }
}
