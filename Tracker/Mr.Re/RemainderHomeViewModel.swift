//
//  RemainderHomeViewModel.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/08/03.
//

import Foundation
import CoreData
import UserNotifications

class RemainderHomeViewModel: ObservableObject {
    
    init() {
        Task {
            await requestNotificationAccess()
        }
    }
    
    func addRemainder(context: NSManagedObjectContext, title: String, text: String, date: Date, id: String) {
        let entity = TaskEntity(context: context)
        entity.title = title
        entity.text = text
        entity.date = date
        entity.id = id
        
        try? context.save()
    }
    
    func deleteRemainder(context: NSManagedObjectContext, object: NSManagedObject) {
        context.delete(object)
        
        try? context.save()
    }
    
    func addNotification(title: String, date: Date, id: String) async throws{
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        try await UNUserNotificationCenter.current().add(request)
        
    }
    
    func removeNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func requestNotificationAccess() async {
        do {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge])
        } catch  {
            print(error)
        }
    }
    
}


enum TitleSection: String, CaseIterable {
    case today = "Today"
    case upcoming = "Upcoming"
    case past = "Past"
}
