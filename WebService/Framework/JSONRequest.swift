import Foundation


/// A request of JSON content type
///
/// ```
/// let request = JSONRequest<AuthenticationRoute, Blank>(route: .logout)
///
/// request.perform { response in
///     print(response)
/// }
///
/// ```
public struct JSONRequest<R: Route, Response: RequestResponse>: Request {
    
    // MARK: - Request
    
    public private(set) var session: URLSession
    
    public private(set) var request: URLRequest
    
    // MARK: - JSONRequest

    /// JSONRequest Initializer
    ///
    /// - Parameters:
    ///   - session: Defaults to URLSession.shared if not specified
    ///   - route: A route to a remote resource
    public init(_ session: URLSession = .shared, route: R) {
        self.session = session
        self.request = URLRequest(url: URL(string: route.description.url)!)
        self.request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        self.request.httpMethod = route.description.method.description
        self.request.httpBody = route.description.method.body as? Data
        self.request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request.setValue("application/json", forHTTPHeaderField: "Accept")
        KeyChain.load(key: .token).flatMap {
            self.request.setValue("Token \($0)", forHTTPHeaderField: "Authorization")
        }
    }
}

