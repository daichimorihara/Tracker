//
//  TaskAdd.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/08/02.
//

import SwiftUI

struct TaskAdd: View {
    @EnvironmentObject var vm: TaskHomeViewModel
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var text = ""
    @State private var date = Date()
    @State private var showAlertText = false
    @State private var showAlertDate = false
    
    @Binding var notificatioinID: String?
    
    var body: some View {
        NavigationView {
            ScrollView {
                TextField("Title", text: $title)
                    .padding()
                    .background(Color.red.opacity(0.4))
                    .padding(.top)
                    .padding(.horizontal)
                

                TextField("Text", text: $text)
                    .padding()
                    .background(Color.red.opacity(0.4))
                    .padding(.top)
                    .padding(.horizontal)
                
                

                DatePicker("",
                           selection: $date,
                           displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.graphical)
                
                Spacer()
            }
            .alert("Title or Text isn't filled", isPresented: $showAlertText, actions: {
                Button("OK", role: .cancel) {  }
            })
            .alert("Can't set task in the past",
                   isPresented: $showAlertDate,
                   actions: {
                Button("OK", role: .cancel) {  }
            })

  
            .navigationTitle("Add Habit")
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        segue()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // delete this habit
                        deleteTask()
                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                    }

                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // save editing
                        if title.isEmpty || text.isEmpty {
                            showAlertText.toggle()
                        } else if Date.now >= date {
                            showAlertDate.toggle()
                        } else {
                            let id = UUID().uuidString
                            vm.addTask(title: title, text: text, date: date, id: id)
                            Task {
                                try await vm.addNotification(title: title, text: text, date: date, id: id)
                            }
                            
                            deleteTask()
                            
                            dismiss()
                        }

                    } label: {
                        Text("Done")
                    }
                }
            }
        }
    }
}

struct TaskAdd_Previews: PreviewProvider {
    static var previews: some View {
        TaskAdd(notificatioinID: .constant(nil))
            .environmentObject(dev.homeVM)
    }
}

extension TaskAdd {
    func segue() {
        text = ""
        title = ""
        date = Date()
    }
    
    func deleteTask() {
        if let identifier = notificatioinID {
            if let entity = vm.service.savedEntity.first(where: { $0.id == notificatioinID }) {
                vm.deleteTask(entity: entity)
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        }
    }
    
}
