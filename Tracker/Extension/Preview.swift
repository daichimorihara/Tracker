//
//  Preview.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/08/02.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let remanderVM = RemainderHomeViewModel()
    
    let homeVM = TaskHomeViewModel()
    let taskModel = TaskModel(id: UUID().uuidString,
                              title: "Twitter Post",
                              text: "Tesla's earning",
                              date: Date().addingTimeInterval(100000))
}
