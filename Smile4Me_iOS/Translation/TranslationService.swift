//
//  TranslationService.swift
//  Smile4Me_iOS
//
//  Created by Adrian on 06.02.26.
//

import Foundation
import Translation

@Observable
class TranslationService {
    var translatedText = ""
    var availableLanguages: [AvailableLanguage] = []
    
    init() {
        getSupportedLanguages()
    }
    
    func getSupportedLanguages() {
        Task { @MainActor in
            let supportedLanguages = await LanguageAvailability().supportedLanguages
            availableLanguages = supportedLanguages.map({ local in
                AvailableLanguage(locale: local)
            }).sorted()
            
        }
    }
    
    func translate(text: String, session: TranslationSession) async throws {
        let response = try await session.translate(text)
        translatedText = response.targetText
    }
    
}
