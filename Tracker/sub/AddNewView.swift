//
//  AddNewView.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/07/27.
//

import SwiftUI

struct AddNewView: View {
    @Environment(\.dismiss) var dismiss
    @State private var eij = ""
    @State private var onRemainder = true
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $eij)
                    .padding()
                    .background(Color.red.opacity(0.4))
                    .padding(.top)
                    .padding(.horizontal)
                
                HStack {
                    ForEach(ColorString.allCases, id: \.rawValue) { color in
                        makeColor(color: color.rawValue)
                            .frame(width: UIScreen.main.bounds.width / 9)
                            .clipShape(Circle())
                    }
                }
                .frame(height: 100)
                
                VStack(alignment: .leading) {
                    Text("Frequency")
                    let weekDays = Calendar.current.weekdaySymbols
                    HStack {
                        ForEach(weekDays, id: \.self) { day in
                            Text(day.prefix(3))
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(10)
                                
                        }
                    }
                }
                .padding(.horizontal)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Remainder")
                            .fontWeight(.bold)
                        Text("Just notification")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Toggle(isOn: $onRemainder) { }
                }
                .padding()
                
                if onRemainder {
                    HStack {
                        Label {
                            Text("12:22")
                        } icon: {
                            Image(systemName: "clock")
                        }
                        .padding()
                        .background(Color.red.opacity(0.3))
                        
                        TextField("Remainder Text", text: $eij)
                            .padding()
                            .background(Color.red.opacity(0.3))
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationTitle("Add Habit")
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // delete this habit
                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                    }

                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // save editing
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
    }
    
    enum ColorString: String, CaseIterable {
        case red, yellow, green, blue, pink, purple, gray
    }
    
    
    func makeColor(color: String) -> Color {
        switch color  {
        case "red": return .red
        case "yellow": return .yellow
        case "green": return .green
        case "blue": return .blue
        case "pink": return .pink
        case "purple": return .purple
        case "gray": return .gray
        default: return .red
        }
    }
}

struct AddNewView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewView()
    }
}
