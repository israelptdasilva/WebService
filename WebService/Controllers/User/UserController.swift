import Foundation


/// A controller for the user model
public struct UserController {
    
    /// UserController initializer
    ///
    /// - Parameter session: A URLSession to perform requests in
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Private
    
    /// A URLSession to perform requests in
    private var session: URLSession
}


public extension UserController {
    
    /// Fetches the list of users
    ///
    /// - Parameters:
    ///   - completionHandler: A completion handler with the request result
    func userList(_ completionHandler: @escaping (Result<UserList, RequestError>) -> ()) {
        JSONRequest<UserRoute, UserList>(session, route: .user(id: 1)).perform { result in
            switch result {
            case .success(let list): break
            case .failure(let error): break
            }
        }
    }
    
    /// Fetches the user by identifier
    ///
    /// - Parameters:
    ///   - identifier: The user remote identifier
    ///   - completionHandler: A completion handler with the request result
    func user(with identifier: Int, _ completionHandler: @escaping (Result<User, RequestError>) -> ()) {
        JSONRequest<UserRoute, User>(session, route: .user(id: identifier)).perform(completionHandler)
    }
}
