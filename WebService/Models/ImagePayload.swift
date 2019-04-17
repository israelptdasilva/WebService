import UIKit


/// A payload for uploading images
public struct ImagePayload: RequestPayload {
    
    /// The UIImage to be uploaded in the request
    var image: UIImage
    
    /// ImagePayload initializer
    public init(image: UIImage) {
        self.image = image
    }
    
    public var body: Data {
        image.jpegData(compressionQuality: 1)
        return image.jpegData(compressionQuality: 1)!
    }
}
