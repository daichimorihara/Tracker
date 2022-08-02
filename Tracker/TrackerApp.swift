//
//  TrackerApp.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/07/27.
//

import SwiftUI

@main
struct TrackerApp: App {
    @StateObject var vm = TaskHomeViewModel()
    var body: some Scene {
        WindowGroup {
            TaskHome()
                .environmentObject(vm)
        }
    }
}
