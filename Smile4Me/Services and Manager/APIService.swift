//
//  APIService.swift
//  Smile4Me
//
//  Created by Adrian Eberhardt on 27.12.25.
//
import Foundation

class APIService {
    let urlString: String
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func getJSON() async throws(APIERROR) -> Joke {
        guard let url = URL(string: urlString) else {
            throw .invalidURL
        }
        do {
            let (data, respone) = try await URLSession.shared.data(from: url)
            guard let httpRespone = respone as? HTTPURLResponse,
                  httpRespone.statusCode == 200
            else {
                throw APIERROR.invalidResponseStatus
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(Joke.self, from: data)
                return decodedData
            } catch {
                throw APIERROR.decodingError(error.localizedDescription)
            }
        } catch {
            throw .dataTaskError(error.localizedDescription)
        }
                
    }
}

enum APIERROR: Error, LocalizedError{
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
