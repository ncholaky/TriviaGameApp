//
//  TriviaManager.swift
//  TriviaGameApp
//
//  Created by Nicoletta Cholaky on 04/07/24.
//

import Foundation
import SwiftUI

class TriviaManager: ObservableObject {
    //save the API's result into a variable, set as an empty array
    private(set)var trivia: [Trivia.Result] = []
    //save the number of questions we fetch in an array
    @Published private(set) var length = 0
    
    //the current index we are at in the results array of the trivia
    //Zero cause by default we want to start with the 1 question of the array (index zero)
    @Published private(set) var index = 0
    
    //Did the user reach then end of the array (the game) ?
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question : AttributedString = ""
    @Published private(set) var answerChoices : [Answer] = []
    @Published private(set) var progress: CGFloat = 0.00

    init () {
        Task.init {
            await fetchTrivia()
        }
    }
    
    func fetchTrivia () async {
        guard let url = URL( string: "https://opentdb.com/api.php?amount=10") else {fatalError("MissingURL")}
        
        // HTTP Request with async await --> designcode.io/advanced-handbook-async-await
        let urlRequest = URLRequest(url:url)
        
        do {
           let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard(response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Eror while fetching data")}
            
            let decoder = JSONDecoder()
            //some JSON are in snake case and they will be converted to camelCase as we declared in the model
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
           let decodedData =  try decoder.decode(Trivia.self, from: data)
            
            DispatchQueue.main.async {
                self.trivia = decodedData.results
                self.length = self.trivia.count
            }
            
        } catch {
            print("Error fetching trivia: \(error)")
        }
    }
    func goToNexQuestion () {
        if index + 1 < length {
            index += 1
            //
        } else {
            reachedEnd = true
        }
    }
    
    func setQuestion() {
        answerSelected = false
        
        //consider the ProgressBar width, 350
        progress = CGFloat(Double(index + 1) / Double(length * 350))
        
        if index < length {
            let currentTriviaQuestion = trivia[index]
            question = currentTriviaQuestion.formattedQuestion
            answerChoices = currentTriviaQuestion.answers
        }
    }
}
