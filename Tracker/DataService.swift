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
    
    func save() {
        do {
            try container.viewContext.save()
        } catch  {
            print("Error saving to Core Data \(error)")
        }
    }
    
    func add(color: String, isRemainderOn: Bool, notificationDate: Date, ids: [String], text: String, title: String, weekDays: [String]) {
        let entity = Habit(context: container.viewContext)
        entity.color = color
        entity.dataAdded = Date()
        entity.isRemainderOn = isRemainderOn
        entity.notificatioinDate = notificationDate
        entity.notificationIDs = ids
        entity.remainderText = text
        entity.title = title
        entity.weekDays = weekDays
        save()
    }
    
    func update(entity: Habit, color: String, isRemainderOn: Bool, notificationDate: Date, ids: [String], text: String, title: String, weekDays: [String]) {
        entity.color = color
        entity.dataAdded = Date()
        entity.isRemainderOn = isRemainderOn
        entity.notificatioinDate = notificationDate
        entity.notificationIDs = ids
        entity.remainderText = text
        entity.title = title
        entity.weekDays = weekDays
        save()
    }
    
    func delete(entity: Habit) {
        container.viewContext.delete(entity)
        save()
    }
}
