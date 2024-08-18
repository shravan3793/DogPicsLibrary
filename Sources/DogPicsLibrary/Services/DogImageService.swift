import Foundation

protocol DogImageServiceProtocol{
    func fetchDogImages(count:Int) async -> [String]?
}

final class DogImageService: DogImageServiceProtocol{
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchDogImages(count:Int) async -> [String]?{
        do{
            return  try await networkManager.requestDogImage(number: count)
        }catch{
            print(error.localizedDescription)
            return nil
        }
        
    }
    
}
