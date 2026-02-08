//
//  ConfigurationAppIntent.swift
//  Smile4Me
//
//  Created by Adrian on 07.02.26.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Joke Options" }
    static var description: IntentDescription { "Choose language and category" }

    // An example configurable parameter.
    @Parameter(title: "Language", default: nil)
    var language: LanguageEntity?
    
    @Parameter(title: "Category", default: nil)
    var categoty: CategoryEntity?
}

struct LanguageEntity: AppEntity {
    static var defaultQuery: LanguageQuery = LanguageQuery()

    
    // id ist was für ein Typ wird deine Variable sein (könnte auch hier String hin machen)
    var id: Language.RawValue

    static var typeDisplayRepresentation: TypeDisplayRepresentation = TypeDisplayRepresentation(
        name: "Language")

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(id)")
    }
}

struct LanguageQuery: EntityQuery {
    // hier werden 3 Sachen benötigt
    
    //1. generieren eines Arrays der languages entities
    func suggestedEntities() async throws -> [LanguageEntity] {
        Language.allCases.map {LanguageEntity(id: $0.rawValue)}
    }
    
    func entities(for identifiers: [String]) async throws -> [LanguageEntity] {
            try await suggestedEntities().filter {identifiers.contains($0.id)}
    }
        
        // default result
    func defaultResult() async -> LanguageEntity? {
            try? await suggestedEntities().first
    }
        
}


struct CategoryEntity: AppEntity {
    static var defaultQuery: CategoryQuery = CategoryQuery()

    
    // id ist was für ein Typ wird deine Variable sein (könnte auch hier String hin machen)
    var id: Category.RawValue

    static var typeDisplayRepresentation: TypeDisplayRepresentation = TypeDisplayRepresentation(
        name: "Category")

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(id)")
    }
}

struct CategoryQuery: EntityQuery {
    // hier werden 3 Sachen benötigt
    
    //1. generieren eines Arrays der Categorys entities
    func suggestedEntities() async throws -> [CategoryEntity] {
        Category.allCases.map {CategoryEntity(id: $0.rawValue)}
    }
    
    func entities(for identifiers: [String]) async throws -> [CategoryEntity] {
            try await suggestedEntities().filter {identifiers.contains($0.id)}
    }
        
        // default result
    func defaultResult() async -> CategoryEntity? {
            try? await suggestedEntities().first
    }
        
}
