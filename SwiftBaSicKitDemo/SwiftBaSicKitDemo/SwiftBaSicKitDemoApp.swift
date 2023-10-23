//
//  SwiftBaSicKitDemoApp.swift
//  SwiftBaSicKitDemo
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import SwiftUI

@main
struct SwiftBaSicKitDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
