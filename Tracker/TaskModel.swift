//
//  TaskModel.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/08/02.
//

import Foundation

struct TaskModel: Identifiable {
    var id: String
    var title: String
    var text: String
    var date: Date   
}
