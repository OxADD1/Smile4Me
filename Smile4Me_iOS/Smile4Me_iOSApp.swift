//
//  Smile4Me_iOSApp.swift
//  Smile4Me_iOS
//
//  Created by Adrian Eberhardt on 04.02.26.
//










import SwiftUI

@main
struct Smile4Me_iOSApp: App {
    @State private var router = Router()
    var body: some Scene {
        WindowGroup {
            StartTabView()
                .environment(router)
                .onOpenURL { url in
                    guard url.scheme == "s4m",
                          url.host == "joke" else { return }
                    //print(url)
                    router.components = url.lastPathComponent
                    router.selectesTab = 0
                }
        }
    }
}
