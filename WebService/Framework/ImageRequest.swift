import Foundation


/// Image upload request
struct ImageRequest<R: Route, Response: RequestResponse>: Request {
    
    // MARK: - Request

    public private(set) var session: URLSession
    
    public private(set) var request: URLRequest
    
    // MARK: - ImageRequest
    
    /// ImageRequest Initializer
    ///
    /// - Parameters:
    ///   - session: Defaults to URLSession.shared if not specified
    ///   - route: A route to a remote resource
    init(_ session: URLSession = .shared, route: R) {
        let boundary = "\(NSUUID().uuidString)"
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"upload\"; filename=\"image.jpeg\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(route.description.method.body as! Data)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)

        self.session = session
        self.request = URLRequest(url: URL(string: route.description.url)!)
        self.request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        self.request.httpMethod = route.description.method.description
        self.request.httpBody = body
        self.request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        self.request.setValue("application/json", forHTTPHeaderField: "Accept")
        KeyChain.load(key: .token).flatMap {
            self.request.setValue("Token \($0)", forHTTPHeaderField: "Authorization")
        }
    }
}
