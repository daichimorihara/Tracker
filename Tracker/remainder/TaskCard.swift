//
//  TaskCard.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/08/02.
//

import SwiftUI

struct TaskCard: View {
    
    let task: TaskModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
            Text(task.text)
            Text(task.date.asDayString())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        
    }
}

struct TaskCard_Previews: PreviewProvider {
    static var previews: some View {
        TaskCard(task: dev.taskModel)
    }
}
