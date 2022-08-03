//
//  TaskDataService.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/08/02.
//

import Foundation
import CoreData

class TaskDataService {
    private let container: NSPersistentContainer
    private let containerName = "HabitTracker"
    private let entityName = "TaskEntity"
    
    @Published var savedEntity = [TaskEntity]()
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            guard error == nil else {
                print("Error loading Core Data")
                return
            }
        }
        getTasks()
    }
    
    func add(title: String, text: String, date: Date, id: String) {
        let entity = TaskEntity(context: container.viewContext)
        entity.title = title
        entity.text = text
        entity.date = date
        entity.id = id
        applyChange()
    }
    
    func update(entity: TaskEntity, title: String, text: String, date: Date, id: String) {
        entity.title = title
        entity.text = text
        entity.date = date
        entity.id = id
        applyChange()
    }
    
    func delete(entity: TaskEntity) {
        container.viewContext.delete(entity)
        applyChange()
    }
    
    private func getTasks() {
        let request = NSFetchRequest<TaskEntity>(entityName: entityName)
        do {
            savedEntity = try container.viewContext.fetch(request)
        } catch  {
            print(error)
        }
    }
    
    
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving to Core Data: \(error.localizedDescription)")
        }
    }
    
    private func applyChange() {
        save()
        getTasks()
    }
}
