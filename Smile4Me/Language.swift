//
//  Language.swift
//  Smile4Me
//
//  Created by Adrian Eberhardt on 27.12.25.
//


enum Language: String,Codable, CaseIterable, Identifiable {
    case en, fr, cs, de, es, pt
    var id: Self { self }
}