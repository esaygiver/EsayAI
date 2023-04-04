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
    
    var body: some View {
        List(historyItemResults) { historyItem in
            Text(historyItem.question ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
