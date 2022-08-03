//
//  RemainderHome.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/08/03.
//

import SwiftUI

struct RemainderHome: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<TaskEntity>
    @State private var section: TitleSection = .today
    @State private var text = ""
    @State private var showAddRemainder = false
    @State private var selectedTask: TaskEntity?
    
    var body: some View {
        VStack {
            Text("Remainder")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .overlay(
                    Button(action: {
                        showAddRemainder.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    }) ,alignment: .trailing
                )
                .padding(.horizontal)
            
            HStack {
                ForEach(TitleSection.allCases, id: \.rawValue) { title in
                    Text(title.rawValue)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity)
                        .background(section == title ? Color.gray : Color.clear)
                        .cornerRadius(15)
                        .onTapGesture {
                            section = title
                        }
                        
                }
            }
            .padding()
            
            ScrollView {
                
//                FilteredView(section: section) { (task: TaskEntity) in
//                    Text(task.text ?? "")
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 5)
//                        .background(Color.blue.opacity(0.2))
//                        .cornerRadius(10)
//                        .onTapGesture {
//                            selectedTask = task
//                            showAddRemainder.toggle()
//                        }
//                }
                FView(section: section) { task in
                    selectedTask = task
                    showAddRemainder.toggle()
                }
                
                Text("------------------------------------------------------").lineLimit(1)
                ForEach(tasks) { task in
                    Text(task.text ?? "YES")
                }
            }
        }
        .sheet(isPresented: $showAddRemainder) {
            selectedTask = nil
        } content: {
            AddRemainderView(selectedTask: $selectedTask)
        }


    }
    
    func add(text: String) {

        let task = TaskEntity(context: moc)
        task.text = text
        
        try? moc.save()
        
    }
}

struct RemainderHome_Previews: PreviewProvider {
    static var previews: some View {
        RemainderHome()
    }
}
