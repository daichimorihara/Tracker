//
//  TrackerApp.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/07/27.
//

import SwiftUI

//@main
//struct TrackerApp: App {
//    @StateObject var vm = TaskHomeViewModel()
//    var body: some Scene {
//        WindowGroup {
//            TaskHome()
//                .environmentObject(vm)
//        }
//    }
//}

@main
struct TrackerApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var vm = RemainderHomeViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(vm)
        }
    }
}
