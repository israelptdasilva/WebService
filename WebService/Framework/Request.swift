import Foundation


/// A protocol that can be used to build and perform a URLRequest
public protocol Request {
    
    /// The request response type
    associatedtype Response: RequestResponse
    
    /// A session to perform the request in
    var session: URLSession { get }

    /// A request built from the route protocol
    var request: URLRequest { get }
}


public extension Request {
    
    /// Performs a URLSession request
    func perform(_ completionHandler: @escaping (Result<Response, RequestError>) -> ()) {
        session.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else { return }
            switch response.status {
            case .ok, .created: completionHandler(.success(Response.deserialize(data)))
            default: completionHandler(.failure(.generic))
            }
        }.resume()
    }
}
