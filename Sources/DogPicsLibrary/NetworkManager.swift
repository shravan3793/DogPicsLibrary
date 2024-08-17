import Foundation

enum APIErrors: Error{
    case invalidBaseUrl
    case unknownError
    case parsingError
    case invalidDogUrl
}

final internal class NetworkManager{
    static let shared = NetworkManager()
    func requestDogImage(number:Int = 1) async throws -> [String]?{
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random/\(number)")
        else{ throw APIErrors.invalidBaseUrl }
        
        let (data,urlResponse) = try await URLSession.shared.data(from: url)
        guard let value = parseData(data, urlResponse) 
        else{ throw APIErrors.parsingError }
        
        guard let arrayStrings = value.message else{ throw APIErrors.invalidDogUrl }
        return arrayStrings
    }
    
    private func parseData(_ data:Data,_ response: URLResponse) -> ResponseModel?{
        guard let response = response as? HTTPURLResponse else{ return nil }
        guard response.statusCode == 200  else{ return nil }
        var value : ResponseModel?
        do{
            value = try JSONDecoder().decode(ResponseModel.self, from: data)
        }catch{
            print("error in decoding reponse model :\(error)")
        }
        return value
    }
}
