//
//  HistoryView.swift
//  EsayAI
//
//  Created by Emirhan Saygiver on 4.04.2023.
//

import SwiftUI

struct HistoryView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: true)])
    private var historyItemResults: FetchedResults<HistoryItem>

    @EnvironmentObject private var model: Model
    @Environment(\.dismiss) private var dismiss
        
    var body: some View {
        List(historyItemResults) { historyItem in
            Text(historyItem.question ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    if let _question = historyItem.question,
                       let _answer = historyItem.answer {
                        model.selectedQuery = Query(question: _question,
                                                    answer: _answer)
                        dismiss()
                    }
                }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(Model())
    }
}
