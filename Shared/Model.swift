//
//  Model.swift
//  EsayAI
//
//  Created by Emirhan Saygiver on 4.04.2023.
//

import Foundation

class Model: ObservableObject {
    
    @Published var queries = [Query]()
    
    func saveQuery(_ query: Query) throws {
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        let historyItem = HistoryItem(context: viewContext)
        historyItem.question = query.question
        historyItem.answer = query.answer
        historyItem.dateCreated = Date()
        try viewContext.save()
    }
}
