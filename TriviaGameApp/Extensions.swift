//
//  Extensions.swift
//  TriviaGameApp
//
//  Created by Nicoletta Cholaky on 03/07/24.
//

import Foundation
import SwiftUI

extension Text {
    func lilacTitle() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("AccentColor"))
    }
}
