import Foundation

class APIService {
    let urlString: String
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func getJSON<T: Decodable>() async throws(APIError) -> T {
        guard let url = URL(string: urlString) else {
            throw .invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
            else {
                throw APIError.invalidResponseStatus
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw APIError.decodingError(error.localizedDescription)
            }
        } catch {
            throw .dataTaskError(error.localizedDescription)
        }
    }
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case dataTaskError(String)
    case invalidResponseStatus
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                NSLocalizedString("The endpoint URL is invalid.", comment: "")
            case .dataTaskError(let string):
                string
            case .invalidResponseStatus:
                NSLocalizedString("The API failed to issue a valid response", comment: "")
            case .decodingError(let string):
                string
        }
    }
}
