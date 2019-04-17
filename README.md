# iOS Web Service Framework
*© Israel Pereira Tavares da Silva*

This project was created to serve as a web service framework for iOS projects that need to consume REST based APIs. A framework in this context means a combination of files that can be used as is or extended in case new functionalities are required. 

## Tools

- [Xcode 10.2](https://developer.apple.com/xcode/)
- [Swift 5](https://www.apple.com/swift/)

## Usage

In order to perform a request that consumes a JSON object two things are required:

- A [Route](https://github.com/ismalakazel/WebService/blob/master/WebService/Framework/Route.swift) conforming Enum
- A [RequestResponse](https://github.com/ismalakazel/WebService/blob/master/WebService/Framework/RequestResponse.swift) conforming model object

Take a look at the following example where a [JSON](https://github.com/ismalakazel/WebService/blob/master/WebService/Framework/JSONRequest.swift) request is performed in order to fetch a [User](https://github.com/ismalakazel/WebService/blob/master/WebService/Models/User/User.swift) model from the user [route](https://github.com/ismalakazel/WebService/blob/master/WebService/Controllers/User/UserRoute.swift):

```swift
JSONRequest<UserRoute, UserList>(session, route: .user(id: 1)).perform { result in
    switch result {
    case .success(let list): break
    case .failure(let error): break
    }
}
```

## The Web Service Controller Pattern

I personally like to create a controller to layout web service requests because the requests can be reused, mocked if necessary, and it gives more flexibility if additional work needs to be done before forwarding the request response is returned to the request caller.

The following is how user related requests are put in a web service controller:

```swift

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
        JSONRequest<UserRoute, UserList>(session, route: .list).perform(completionHandler)
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
```

Using the web service controller in a view controller would look like this:

```swift
/// A view controller to play around with the web service framework
class ViewController: UIViewController {

    /// The user controller
    private let webservice = UserController()

    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webservice.userList { result in
            print(result)
        }
    }
}
```

## Mocking Requests

Mocking a request can be done with a custom [URLProtocol](https://github.com/ismalakazel/WebService/blob/master/WebServiceTests/Models/MockURLProcotol.swift) and a request response saved in a separate JSON file. Check the [tests](https://github.com/ismalakazel/WebService/blob/master/WebServiceTests/Controllers/UserControllerTests.swift) that were created for the user web service controller for a concrete example on how to mock url requests. Here is one example:

```swift
/// Fetches a list of users
func testGetUserList() {
    let expect = expectation(description: "fetch the list of users")

    MockURLProcotol.block = { request in
        let status = Status.ok.rawValue
        let response = MockURLProcotol.loadJSONResponse(with: "userList")
        return (status, response)
    }

    controller.userList { result in
        guard case .success(let list) = result else { return XCTFail() }
        XCTAssertNotNil(list.data)
        expect.fulfill()
    }

    wait(for: [expect], timeout: 1)
}
```

For more details on creating and using a custom URLProtocol See [Testing Tips & Tricks from WWDC 2018](https://developer.apple.com/videos/play/wwdc2018/417/). 

## License

> My teaching, if that is the word you want to use, has no copyright. You are free to reproduce, distribute, interpret, misinterpret, distort, garble, do what you like, even claim authorship, without my consent or the permission of anybody. 
**U. G. Krishnamurti**
