//
//  TaskHome.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/08/02.
//

import SwiftUI

struct TaskHome: View {
    @EnvironmentObject var vm: TaskHomeViewModel
    @State private var showAdd = false
    @State private var notificationID: String?
    
    var body: some View {
        VStack {
            titleBar
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(vm.tasks) { task in
                    TaskCard(task: task)
                        .onTapGesture {
                            notificationID = task.id
                            showAdd.toggle()
                        }
                }
            }
        }
        .sheet(isPresented: $showAdd) {
            
        } content: {
            TaskAdd(notificatioinID: $notificationID)
        }

    }
}

struct TaskHome_Previews: PreviewProvider {
    static var previews: some View {
        TaskHome()
            .environmentObject(dev.homeVM)
    }
}

extension TaskHome {
    private var titleBar: some View {
        Text("Habits")
            .font(.title)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .overlay(alignment: .trailing) {
                Button {
                    notificationID = nil
                    showAdd.toggle()
                } label: {
                    Image(systemName: "plus")
                        .padding()
                }
            }
    }
}
