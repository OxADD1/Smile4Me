//
//  JokeManager.swift
//  Smile4Me
//
//  Created by Adrian Eberhardt on 27.12.25.
//
import Foundation
import OSLog


class JokeManager {
    
    func getJoke(
        category: Category,
        language: Language = .en
    ) async throws -> Joke {
        
        let url = "https://v2.jokeapi.dev/joke/\(category.rawValue)?lang=\(language.rawValue)&blacklistFlags=nsfw,religious,political,racist,sexist,explicit"
        let apiService = APIService(urlString: url)
        do {
            return try await apiService.getJSON()
        } catch {
            throw error
        }
    }
}
