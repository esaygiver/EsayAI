//
//  Query.swift
//  EsayAI
//
//  Created by Emirhan Saygiver on 4.04.2023.
//

import Foundation

struct Query: Identifiable, Hashable {
    let id = UUID()
    let question: String
    let answer: String
}
