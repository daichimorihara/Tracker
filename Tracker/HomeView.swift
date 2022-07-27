//
//  HomeView.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/07/27.
//

import SwiftUI

struct HomeView: View {
    @State private var showAddView = false
    var body: some View {
        VStack {
            Text("Habits")
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    Button {
                        showAddView.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                    }
                }
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(0..<4, id: \.self) {_ in
                    Text("NEOBNEIO")
                        .frame(height: 300)
                        .background(Color.blue)
                }
            }
        }
        .sheet(isPresented: $showAddView) {
            
        } content: {
            AddNewView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
