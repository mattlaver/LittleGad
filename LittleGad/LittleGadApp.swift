//
//  LittleGadApp.swift
//  LittleGad
//
//  Created by Matt Laver on 16/11/2022.
//

import SwiftUI

@main
struct LittleGadApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
