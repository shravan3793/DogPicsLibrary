import Foundation

enum APIErrors: Error{
    case invalidBaseUrl
    case unknownError
    case parsingError
    case invalidDogUrl
}

protocol NetworkSessionProtocol{
    func data(from url: URL) async throws -> (Data,URLResponse)
}
protocol NetworkManagerProtocol{
    func requestDogImage(number:Int) async throws -> [String]?
}

extension URLSession : NetworkSessionProtocol{
}

final class NetworkManager: NetworkManagerProtocol{
    static let shared = NetworkManager()
    private let session: NetworkSessionProtocol
    private let parser : DataParserProtocol
    init(session:NetworkSessionProtocol = URLSession.shared,  parser: DataParserProtocol = DefaultDataParser()) {
        self.parser = parser
        self.session = session
    }
    
    func requestDogImage(number:Int = 1) async throws -> [String]?{
        let strBaseUrl = "https://dog.ceo/api/breeds/image/random/"
        guard let url = URL(string: strBaseUrl + String(number))
        else{ throw APIErrors.invalidBaseUrl }
        
        let (data,urlResponse) = try await session.data(from: url)
        return try parser.parse(data, response: urlResponse)
    }
}
