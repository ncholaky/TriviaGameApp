//
//  QuestionView.swift
//  TriviaGameApp
//
//  Created by Nicoletta Cholaky on 04/07/24.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var triviaManager :  TriviaManager
    var body: some View {
        VStack (spacing: 40) {
            HStack {
                Text("Trivia Game")
                    .lilacTitle()
                Spacer()
                Text("1 out of 10")
                    .foregroundColor(Color("AccentColor"))
                    .fontWeight(.heavy)
            }
            
            ProgressBar(progress: 40)
            
            VStack(alignment: .leading, spacing: 20){
                Text("Bulls are attracted to the color red.")
                    .font(.system(size:20))
                    .bold()
                    .foregroundColor(.gray)
                
                AnswerRow(answer: Answer(text:"false", isCorrect: true))
                AnswerRow(answer: Answer(text:"true", isCorrect: false))
            }
            
            PrimaryButton(text:"Next")
            
            Spacer()
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.984313725490196, green:0.9294117647058824, blue: 0.8470588235294118))
        // to hide back option
        .navigationBarHidden(true)
    }
}
struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .environmentObject(TriviaManager())
    }
}
