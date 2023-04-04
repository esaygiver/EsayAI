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
    @EnvironmentObject private var model: Model
    
    private let openAI = OpenAISwift(authToken: "MockAPIKey")
    
    private var isValidText: Bool {
        !chatText.isEmptyOrWhiteSpace
    }
    
    private func performSearch() {
        openAI.sendCompletion(with: chatText,
                              maxTokens: 500) { result in
            switch result {
            case .success(let success):
                if let answer = success.choices?.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) {
                    
                    let query = Query(question: chatText, answer: answer)
    
                    DispatchQueue.main.async {
                        model.queries.append(query)
                    }
                    
                    do {
                        try model.saveQuery(query)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    chatText = ""
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    var body: some View {
        VStack {
            List(model.queries) { query in
                VStack {
                    Text(query.question)
                        .fontWeight(.semibold)
                    Text(query.answer)
                }
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
            .environmentObject(Model())
    }
}
