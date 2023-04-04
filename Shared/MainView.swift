//
//  MainView.swift
//  EsayAI
//
//  Created by Emirhan Saygiver on 4.04.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var chatText = ""
    
    private var isValidText: Bool {
        !chatText.isEmptyOrWhiteSpace
    }
    
    private func performSearch() {
        
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextField("Ask ChatGPT...", text: $chatText)
                    .textFieldStyle(.roundedBorder)
                    .border(.brown)
                
                Button {
                    performSearch()
                } label: {
                    Image(systemName: "paperplane.circle.fill")
                        .font(.title)
                        .rotationEffect(.degrees(45))
                }
                .buttonStyle(.borderless)
                .tint(.blue)
                .disabled(!isValidText)

            }
        }.padding()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
