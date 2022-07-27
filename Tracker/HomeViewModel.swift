//
//  HomeViewModel.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/07/27.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var habits = [Habit]()
    let service = DataService()
    
    
    init() {
        fetchHabits()
    }
    
    func fetchHabits() {
        habits = service.getHabits()
    }
}
