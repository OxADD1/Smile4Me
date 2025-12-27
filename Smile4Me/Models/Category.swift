//
//  Category.swift
//  Smile4Me
//
//  Created by Adrian Eberhardt on 27.12.25.
//


enum Category: String, Codable, CaseIterable, Identifiable  {
    case `Any`, Programming, Misc, Dark, Pun, Spooky, Christmas // Any muss in `sein
    var id: Self { self }
}