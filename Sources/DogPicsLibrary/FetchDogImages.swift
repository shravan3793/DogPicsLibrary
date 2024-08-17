import Foundation
import UIKit
import CoreData

public class FetchDogImages{
    
    public init() {}
    
    ///Gets one image of a dog
    public func getImage() async -> UIImage?
    {
        guard let image = await getImages(withCount: 1)?[0] else{ return nil }
        return image
    }
    ///Gets number of images
    public func getImages(withCount number: Int) async -> [UIImage?]?{
        var arrImages = [UIImage?]()
        
        guard let arrStringsOfURL =  await getURLStringsFromServer(withCount: number)
        else{ return nil}
        
        await withTaskGroup(of: UIImage?.self) { group in
            for stringOfUrl in arrStringsOfURL {
                group.addTask {
                    await self.downloadImage(from: stringOfUrl)
                }
            }
            
            for await image in group{
                arrImages.append(image)
            }
        }
        return arrImages
    }
    
    
    ///get the array( of links) of the dog images
    func getURLStringsFromServer(withCount count:Int) async -> [String]?{
        var imageURLs : [String]?
        do{
            imageURLs =  try await NetworkManager.shared.requestDogImage(number: count)
        }catch{
            print(error.localizedDescription)
        }
        return imageURLs
    }
    
    
    ///download image from specific url
    func downloadImage(from str: String) async -> UIImage?{
        guard let url = URL(string: str) else { return  nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                return nil
            }
            return image
        }catch{
            print("error fetching an image using url: \(error.localizedDescription)")
        }
        return nil
    }
    
}
