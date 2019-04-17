import UIKit
import WebService


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

