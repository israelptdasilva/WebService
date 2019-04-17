import Foundation


/// Configure a URLSession with this protocol to mock HTTP responses
///
/// How to configure a session:
/// ```
/// let configuration = URLSessionConfiguration.ephemeral
/// configuration.protocolClasses = [MockURLProcotol.self]
/// session = URLSession(configuration: configuration)
/// ```
/// Reference: https://developer.apple.com/videos/play/wwdc2018/417/
class MockURLProcotol: URLProtocol {
    
    /// A static property that defines the request status and response
    ///
    /// This property needs to be set or else the program will throw
    /// an exception. It is set to nil in stopLoading() in order to have
    /// future request implement their own status and response.
    static var block: ((URLRequest) throws -> (Int, Data))?
    
    // MARK: - URLProtocol
    
    /// Needs to be overriden or else exception is thrown
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    /// Needs to be overriden or else exception is thrown
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    /// Use this method to mock the request response
    override func startLoading() {
        guard let handler = MockURLProcotol.block else { fatalError("MockURLProcotol.block needs to be set") }
        do {
            let (status, data) = try handler(request)
            let response = HTTPURLResponse(url: request.url!, statusCode: status, httpVersion: nil, headerFields: nil)!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    /// Needs to be overriden or else exception is thrown
    override func stopLoading() {
        MockURLProcotol.block = nil
    }
}


extension MockURLProcotol {
    
    /// Loads a JSON file from disk
    ///
    /// - Parameter name: The file name
    /// - Returns: Data from the JSON file
    static func loadJSONResponse(with name: String) -> Data {
        let path = Bundle(for: self).path(forResource: name, ofType: "json")!
        return try! Data(contentsOf: URL(fileURLWithPath: path), options: [])
    }
}
