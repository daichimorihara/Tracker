//
//  HomeView.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/07/27.
//

import SwiftUI

struct HomeView: View {
    @State private var showAddView = false
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        VStack {
            titleBar
            
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(0..<2, id: \.self) {_ in
                    HabitCard()
                    
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

extension HomeView {
    private var titleBar: some View {
        Text("Habits")
            .font(.title)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .overlay(alignment: .trailing) {
                Button {
                    showAddView.toggle()
                } label: {
                    Image(systemName: "plus")
                        .padding()
                }
            }
    }
}
