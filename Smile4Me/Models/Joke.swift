//
//  Joke.swift
//  Smile4Me
//
//  Created by Adrian Eberhardt on 27.12.25.
//

struct Joke: Codable {
    let id: Int
    let category: String
    let type: JokeTyp
    let lang: String
    let setup: String?
    let delivery: String?
    let joke: String?
}
