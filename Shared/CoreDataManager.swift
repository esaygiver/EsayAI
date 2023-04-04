//
//  CoreDataManager.swift
//  EsayAI
//
//  Created by Emirhan Saygiver on 4.04.2023.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol { }

class CoreDataManager: CoreDataManagerProtocol {
    
    static let shared: CoreDataManager = .init()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "HistoryModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error {
                fatalError("CoreData Store failed \(error.localizedDescription)")
            }
        }
    }
}
