//
//  MainView.swift
//  LittleGad
//
//  Created by Matt Laver on 18/11/2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Entries", systemImage: "list.dash")
                }
            ContactsMainView()
                .tabItem {
                    Label("Contacts", systemImage: "square.and.pencil")
                }
            
            DebugMainView()
                .tabItem {
                    Label("Debug", systemImage: "square.and.pencil")
                }

        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
