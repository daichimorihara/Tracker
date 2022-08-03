//
//  AddRemainderView.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/08/03.
//

import SwiftUI

struct AddRemainderView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var vm: RemainderHomeViewModel
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var text = ""
    @State private var date = Date()
    @State private var showAlertText = false
    @State private var showAlertDate = false
    @Binding var selectedTask: TaskEntity?
   
    
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
            .onAppear(perform: {
                if let task = selectedTask {
                    text = task.text!
                    title = task.title!
                    date = task.date!
                }
            })
            .navigationTitle("Add Remainder")
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        undo()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        if let task = selectedTask {
                            vm.removeNotification(id: task.id!)
                            vm.deleteRemainder(context: moc, object: task)
                        }
                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                    }
                    .opacity(selectedTask == nil ? 0 : 1)

                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if let task = selectedTask {
                            vm.removeNotification(id: task.id!)
                            vm.deleteRemainder(context: moc, object: task)
                        }
                        let id = UUID().uuidString
                        vm.addRemainder(context: moc,
                                        title: title,
                                        text: text,
                                        date: date,
                                        id: id)
                        Task {
                            try? await vm.addNotification(title: title,
                                                          date: date,
                                                            id: id)
                        }
                        
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                    .disabled(text.isEmpty || title.isEmpty ||
                              date < Date()
                    )
                }
            }
        }
    }
    
    func undo() {
        text = ""
        title = ""
        date = Date()
    }
}

struct AddRemainderView_Previews: PreviewProvider {
    static var previews: some View {
        AddRemainderView(selectedTask: .constant(nil))
    }
}
