//
//  TriviaManager.swift
//  TriviaGameApp
//
//  Created by Nicoletta Cholaky on 04/07/24.
//

import Foundation

class TriviaManager: ObservableObject {
    //save the API's result into a variable, set as an empty array
    private(set)var trivia: [Trivia.Result] = []
    //save the number of questions we fetch in an array
    @Published private(set) var length = 0
    
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
}
