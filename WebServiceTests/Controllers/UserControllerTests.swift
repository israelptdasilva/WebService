import XCTest
@testable import WebService


/// Unit tests the UserController requests using MockURLProcotol
final class UserControllerTests: XCTestCase {
    
    private var controller: UserController!
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProcotol.self]
        controller = UserController(session: URLSession(configuration: configuration))
    }
    
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
    
    /// Fetches the user profile by the user remote identifier
    func testGetUserProfile() {
        let expect = expectation(description: "fetch the user profile")
        
        MockURLProcotol.block = { request in
            let status = Status.ok.rawValue
            let response = MockURLProcotol.loadJSONResponse(with: "user")
            return (status, response)
        }
        
        controller.user(with: 1) { result in
            guard case .success(let user) = result else { return XCTFail() }
            XCTAssertNotNil(user.id)
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1)
    }
}
