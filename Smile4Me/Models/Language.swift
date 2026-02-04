//
//  Language.swift
//  Smile4Me
//
//  Created by Adrian Eberhardt on 27.12.25.
//


enum Language: String,Codable, CaseIterable, Identifiable {
    case en, fr, cs, de, es, pt
    var id: Self { self }
    
    var full: String {
        switch self {
        case .en:
            "English"
        case .fr:
            "French"
        case .cs:
            "Czeck"
        case .de:
            "German"
        case .es:
            "Spanish"
        case .pt:
            "Portugiese"
        }
    }
}
