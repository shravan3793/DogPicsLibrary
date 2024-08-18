import UIKit

protocol ImageDownloaderProtocol{
    func downloadImage(from url: String) async -> UIImage?
}

final class ImageDownloader : ImageDownloaderProtocol{
    private let session: NetworkSessionProtocol
    public  init(session: NetworkSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    ///download image from specific url
    func downloadImage(from str: String) async -> UIImage?{
        guard let url = URL(string: str) else { return  nil }
        
        do {
            let (data, _) = try await session.data(from: url)
            return UIImage(data: data)
        }catch{
            print("error fetching an image using url: \(error.localizedDescription)")
            return nil
        }
    }
    
}
