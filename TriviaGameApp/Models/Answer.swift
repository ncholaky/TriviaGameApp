//
//  Answer.swift
//  TriviaGameApp
//
//  Created by Nicoletta Cholaky on 04/07/24.
//

import Foundation
struct Answer: Identifiable {
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}
