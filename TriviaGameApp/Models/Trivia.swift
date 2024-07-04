//
//  Trivia.swift
//  TriviaGameApp
//
//  Created by Nicoletta Cholaky on 04/07/24.
//

import Foundation
//we follow the structure of the trivia API
struct Trivia: Decodable {
    var results : [Result]
    
    struct Result: Decodable, Identifiable {
        //the API Doesn't have an ID, we will create it for each question
        var id: UUID {
            UUID()
        }
        var category: String
        var type: String
        var difficulty: String
        var question: String
        var correctAnswer: String
        var incorrectAnswers: [String]
        
        //custom extra
        //allows to convert markdown from the API into a string
        var formattedQuestion: AttributedString {
            do {
                return try AttributedString(markdown: question)
            } catch {
                print("Error setting formattedQuestion: \(error)")
                return ""
            }
        }
        
        //our custom array of Answers. We can centralize right and wrong questions in just one place
        var answers: [Answer] {
            do {
                let correct =  [ Answer(text: try AttributedString(markdown: correctAnswer), isCorrect: true)]
                let incorrects = try incorrectAnswers.map { answer in
                    Answer(text:try AttributedString (markdown: answer), isCorrect: false)
                }
                
                let allAnswers = correct + incorrects
                
                //if we don't shuffle the answers, the right ones will always be the first
                return allAnswers.shuffled()
                
            } catch {
                print("Error setting answers: \(error)")
                return []
            }
        }
    }
}
