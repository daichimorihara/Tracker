//
//  TaskHomeViewModel.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/08/02.
//

import Foundation
import UserNotifications
import Combine

class TaskHomeViewModel: ObservableObject {
    @Published var tasks = [TaskModel]()
    
    let service = TaskDataService()
    var cancellables = Set<AnyCancellable>()
    init() {
        addSubscribers()
        Task {
            await requestNotificationAccess()
        }
    }
    
    func addSubscribers() {
        service.$savedEntity
            .map { outputs -> [TaskModel] in
                var taskModels = [TaskModel]()
                for output in outputs {
                    let task = TaskModel(id: output.id ?? "", title: output.title ?? "", text: output.text ?? "", date: output.date ?? Date())
                    taskModels.append(task)
                }
                return taskModels
            }
            .sink { [weak self] returnedTasks in
                self?.tasks = returnedTasks
            }
            .store(in: &cancellables)
       
    }
    
    func requestNotificationAccess() async {
        do {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert])
        } catch {
            print(error)
        }

    }
    
    func addNotification(title: String, text: String, date: Date, id: String) async throws {
   
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = text
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
    
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        try await UNUserNotificationCenter.current().add(request)
        
    }
    
    func removeNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func updateTask(entity: TaskEntity, title: String, text: String, date: Date, id: String) {
        service.update(entity: entity, title: title, text: text, date: date, id: id)
    }
    
    func deleteTask(entity: TaskEntity) {
        service.delete(entity: entity)
    }
    
    func addTask(title: String, text: String, date: Date, id: String) {
        service.add(title: title, text: text, date: date, id: id)
    }
    
}
