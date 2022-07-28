//
//  HabitCard.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/07/28.
//

import SwiftUI

struct HabitCard: View {
    var body: some View {
        VStack() {
            HStack {
                Text("IGEHIGE")
                Spacer()
                Text("2 times a week")
            }
            .padding()
            let calendar = Calendar.current
            let currentWeek = calendar.dateInterval(of: .weekOfMonth, for: Date())
            let symbols = calendar.weekdaySymbols
            let startDate = currentWeek?.start ?? Date()
//            let plot = symbols.indices.map{ index -> (String, Date)
//
//            }
            let plot = symbols.indices.compactMap { index -> (String, Date) in
                let date = calendar.date(byAdding: .day, value: index, to: startDate) ?? Date()
                return (symbols[index], date)
            }
            HStack {
                ForEach(plot.indices, id: \.self) { index in
                    let item = plot[index]
                    VStack {
                        Text(item.0.prefix(3))
                            .frame(maxWidth: .infinity)
                        
                        Text(item.1.asDayString())
                            .frame(width: UIScreen.main.bounds.width / 9, height: UIScreen.main.bounds.width / 9)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                }
            }
            
            
            
        }
        .padding(.bottom)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(15)
        .padding(.horizontal, 5)
        
        
    }
}

struct HabitCard_Previews: PreviewProvider {
    static var previews: some View {
        HabitCard()
    }
}
