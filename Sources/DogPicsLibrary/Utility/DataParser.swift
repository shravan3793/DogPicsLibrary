import Foundation

protocol DataParserProtocol {
    func parse(_ data: Data, response: URLResponse) throws -> [String]?
}

class DefaultDataParser : DataParserProtocol{
    func parse(_ data: Data, response: URLResponse) throws -> [String]? {
        guard let response = response as? HTTPURLResponse else{ return nil }
        guard response.statusCode == 200  else{ return nil }
        do{
            let value = try JSONDecoder().decode(ResponseModel.self, from: data)
            guard let arrayStrings = value.message else {
                throw APIErrors.invalidDogUrl
            }
            return arrayStrings
        }catch{
            print("error in decoding reponse model :\(error)")
            throw APIErrors.invalidDogUrl
        }
    }
}
