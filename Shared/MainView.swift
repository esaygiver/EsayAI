//
//  MainView.swift
//  EsayAI
//
//  Created by Emirhan Saygiver on 4.04.2023.
//

import SwiftUI
import OpenAISwift

struct MainView: View {
    
    @State private var chatText = ""
    @State private var answers = [String]()
    
    private let openAI = OpenAISwift(authToken: "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")
    
    private var isValidText: Bool {
        !chatText.isEmptyOrWhiteSpace
    }
    
    private func performSearch() {
        openAI.sendCompletion(with: chatText, maxTokens: 500) { result in
            switch result {
            case .success(let success):
                if let answer = success.choices?.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) {
                    answers.append(answer)
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    var body: some View {
        VStack {
            List(answers, id: \.self) { answer in
                Text(answer)
            }
            Spacer()
            HStack {
                TextField("Ask ChatGPT...", text: $chatText)
                    .textFieldStyle(.roundedBorder)
                    .border(.brown)
                    .autocorrectionDisabled()
                
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
