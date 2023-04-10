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
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(model.queries) { query in
                        if #available(macOS 13.0, *) {
                            VStack(alignment: .leading) {
                                Text(query.question)
                                    .fontWeight(.semibold)
                                Text(query.answer)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 10)
                                .id(query.id)
                                .listRowSeparator(.hidden)
                        } else {
                            // Fallback on earlier versions
                        }
                    }.listStyle(.plain)
                        .onChange(of: model.queries) { query in
                            guard !model.queries.isEmpty else {
                                return
                            }
                            
                            if let lastQuery = model.queries.last {
                                withAnimation {
                                    proxy.scrollTo(lastQuery.id)
                                }
                            }
                        }
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
            .onChange(of: model.selectedQuery) { query in
                model.queries.append(query)
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Model())
    }
}
