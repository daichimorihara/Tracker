//
//  HomeViewModel.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/07/27.
//

import Foundation
import UserNotifications

class HomeViewModel: ObservableObject {
    @Published var habits = [Habit]()
    @Published var title = ""
    @Published var text = ""
    
    let service = DataService()
    
    
    init() {
        //fetchHabits()
        Task {
            await requestNotificationAccess()
        }
        Task {
            await scheduleNotification()
        }
    }
    
    func requestNotificationAccess() async {
        do {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert])
        } catch {
            print(error)
        }

    }
    
    func scheduleNotification() async {
        let content = UNMutableNotificationContent()
        content.title = "Do exercise"
        content.subtitle = "Go to Gym"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 15
        dateComponents.minute = 46
        dateComponents.weekday = 5
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        do {
            try await UNUserNotificationCenter.current().add(request)
        } catch  {
            print(error)
        }
        
    }
    
    func fetchHabits() {
        habits = service.getHabits()
    }
}
