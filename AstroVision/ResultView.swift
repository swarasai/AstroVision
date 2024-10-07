//
//  ResultView.swift
//  AstroVision
//
//  Created by Swarasai Mulagari on 10/6/24.
//

import SwiftUI

struct ResultView: View {
    let resultText: String
    @Environment(\.presentationMode) var presentationMode // To handle the back button
    
    var body: some View {
        VStack {
            Text(resultText)
                .font(.custom("AvenirNext-Bold", size: 24)) // Set the font to Avenir Next Bold
                .foregroundColor(.black) // Set the text color to black
                .padding()
                .multilineTextAlignment(.center)
            
            Button(action: {
                // Dismiss the ResultView and go back to the previous view
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Back")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure the view takes up the full screen
        .background(Color(red: 0.784, green: 0.894, blue: 0.937)) // Set the background color
        .ignoresSafeArea() // Make sure the background covers the full screen, including safe areas
        .navigationBarHidden(true) // Hide the default navigation bar
    }
}
