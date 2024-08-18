import Foundation
import UIKit

public class FetchDogImages{
    
    private let dogImageService: DogImageServiceProtocol
    private let imageDownloader: ImageDownloaderProtocol
    
    init(dogImageService: DogImageServiceProtocol ,
         imageDownloader: ImageDownloaderProtocol) {
        self.dogImageService = dogImageService
        self.imageDownloader = imageDownloader
    }
    
    // Public initializer with internal factory method
    public convenience init() {
        let dogImageService = DogImageService(networkManager: NetworkManager.shared)
        let imageDownloader = ImageDownloader(session: URLSession.shared)
        self.init(dogImageService: dogImageService, imageDownloader: imageDownloader)
    }
    
    ///Fetches one image of a dog
    public func getImage() async -> UIImage?{
        return await getImages(withCount: 1)?.first ?? nil
    }
    
    ///Gets number of images
    public func getImages(withCount number: Int) async -> [UIImage?]?{
        var arrImages = [UIImage?]()
        
        guard let arrStringsOfURL =  await dogImageService.fetchDogImages(count: number) else{ return nil }
        
        await withTaskGroup(of: UIImage?.self) { group in
            for stringOfUrl in arrStringsOfURL {
                group.addTask {
                    await self.imageDownloader.downloadImage(from: stringOfUrl)
                }
            }
            
            for await image in group{
                arrImages.append(image)
            }
        }
        return arrImages
    }
}
