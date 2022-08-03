//
//  FView.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/08/03.
//

import SwiftUI
import CoreData

struct FView: View{
    
    @FetchRequest var request: FetchedResults<TaskEntity>
    //var section: TitleSection
    let tapped: (TaskEntity) -> ()
    
    init(section: TitleSection, tapped: @escaping (TaskEntity) -> ()) {
        self.tapped = tapped
        let calendar = Calendar.current
        var predicate: NSPredicate!
        let today = calendar.startOfDay(for: Date())
        let tommorow = calendar.date(byAdding: .day, value: 1, to: today)!
        let future = Date.distantFuture
        let past = Date.distantPast
        switch section {
        case .today:
            predicate = NSPredicate(format: "date >= %@ AND date < %@", argumentArray: [today, tommorow])
            
        case .upcoming:
            predicate = NSPredicate(format: "date >= %@ AND date < %@", argumentArray: [tommorow, future])
        case .past:
            predicate = NSPredicate(format: "date >= %@ AND date < %@", argumentArray: [past, today])
        }
        _request = FetchRequest(entity: TaskEntity.entity(),
                                sortDescriptors: [.init(keyPath: \TaskEntity.date,
                                                        ascending: false)],
                                predicate: predicate)
    }
    
    var body: some View {
        ZStack {
            if request.isEmpty {
                Text("No tasks found")
            } else {
                VStack {
                    ForEach(request, id: \.objectID) { object in
                        VStack {
                            Text(object.text!)
                            Text(object.title!)
                            Text(object.date!.asDayString())
                        }
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .onTapGesture {
                            tapped(object)
                        }
                    }
                }
            }
        }
    }
    
}

//struct FView_Previews: PreviewProvider {
//    static var previews: some View {
//        FView(section: .today, tapped: (TaskEntity) -> ())
//    }
//}
