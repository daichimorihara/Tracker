//
//  DataService.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/07/27.
//

import Foundation
import CoreData

class DataService {
    private let container: NSPersistentContainer
    private let containerName = "HabitTracker"
    private let entityName = "Habit"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data: \(error)")
            }
        }
    }
    
    func getHabits() -> [Habit] {
        let request = NSFetchRequest<Habit>(entityName: entityName)
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error fetch Habit Data \(error)")
            return []
        }
    }
}
