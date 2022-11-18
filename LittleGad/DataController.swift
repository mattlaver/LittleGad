//
//  DataController.swift
//  LittleGad
//
//  Created by Matt Laver on 16/11/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "Bridgewater")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
