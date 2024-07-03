//
//  PrimaryButton.swift
//  TriviaGameApp
//
//  Created by Nicoletta Cholaky on 03/07/24.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var background: Color = Color("AccentColor")
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .padding(.horizontal)
            .background(background)
            .cornerRadius(30)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View{
        PrimaryButton(text: "Next")
    }
    
}

