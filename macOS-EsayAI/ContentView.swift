//
//  ContentView.swift
//  macOS-EsayAI
//
//  Created by Emirhan Saygiver on 4.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if #available(macOS 13.0, *) {
            NavigationSplitView {
                HistoryView()
            } detail: {
                MainView()
            }
        } else {
            MainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}
