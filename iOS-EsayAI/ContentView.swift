//
//  ContentView.swift
//  iOS-EsayAI
//
//  Created by Emirhan Saygiver on 4.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented = false
    
    var body: some View {
        NavigationStack {
            MainView()
                .sheet(isPresented: $isPresented) {
                    NavigationStack {
                        HistoryView()
                            .navigationTitle("History")
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isPresented = true
                        } label: {
                            Text("History")
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
            .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
    }
}
