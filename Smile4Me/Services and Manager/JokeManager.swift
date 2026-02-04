//
//  JokeManager.swift
//  Smile4Me
//
//  Created by Adrian Eberhardt on 27.12.25.
//
import Foundation
import OSLog


class JokeManager {
    let logger = Logger(subsystem: "Smile4Me.Service", category: "JokeManager")
    let issueURL = "https://github.com/Sv443-Network/JokeAPI/issues/new?assignees=Sv443&1abels=joke+edit&projects=&template=3_edit_a_joke.md&title="
    func getJoke(
        category: Category,
        language: Language = .en
    ) async throws -> Joke {
        let url = "https://v2.jokeapi.dev/joke/\(category.rawValue)?lang=\(language.rawValue)&blacklistFlags=nsfw,religious,political,racist,sexist,explicit"
        logger.info("\(url)")
        let apiService = APIService(urlString: url)
        do {
            return try await apiService.getJSON()
        } catch {
            throw error
        }
    }
}
