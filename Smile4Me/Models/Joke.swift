//
//  Joke.swift
//  Smile4Me
//
//  Created by Adrian Eberhardt on 27.12.25.
//

struct Joke: Codable, Equatable {
    let id: Int
    let category: Category
    let type: JokeTyp
    let lang: Language
    let setup: String?
    let delivery: String?
    let joke: String?
    
    var fullJoke: String {
        switch type {
        case .twopart:
            (setup ?? "") + "\n\n" + (delivery ?? "")
        case .single:
            joke ?? "" 
        }
    }
    
    static let single = Joke(
        id: 1,
        category: Category.Misc,
        type: .single,
        lang: .en,
        setup: nil,
        delivery: nil,
        joke: "Never date a baker. They are too kneady."
    )
    
    static var twopart = Joke(
        id: 2,
        category: .Pun,
        type: .twopart,
        lang: .en,
        setup: "Which is faster? Hot or cold?",
        delivery: "Hot, because you can catch a cold.",
        joke: nil
    )
}
