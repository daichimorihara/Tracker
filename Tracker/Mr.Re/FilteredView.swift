//
//  FilteredView.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/08/03.
//

import SwiftUI
import CoreData

struct FilteredView<Content: View, T>: View where T: NSManagedObject {
    @FetchRequest var request: FetchedResults<T>
    //var section: TitleSection
    let content: (T) -> Content
    init(section: TitleSection, @ViewBuilder content: @escaping (T) -> Content) {
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
        self.content = content
    }
    
    var body: some View {
        ZStack {
            if request.isEmpty {
                Text("No tasks found")
            } else {
                VStack {
                    ForEach(request, id: \.objectID) { object in
                        self.content(object)
                    }
                }
            }
        }
    }
}

//struct FilteredView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredView()
//    }
//}
