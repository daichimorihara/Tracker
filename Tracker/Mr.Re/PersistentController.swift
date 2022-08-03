//
//  PersistentController.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/08/03.
//

import Foundation
import CoreData

class PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "HabitTracker")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error loading Core Data")
            }
        }
    }
}
