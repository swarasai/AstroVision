//
//  ResultsView.swift
//  AstroVision
//
//  Created by Swarasai Mulagari on 10/6/24.
//

import SwiftUI

struct ResultsView: View {
    let resultText: String  // The message to be displayed

    var body: some View {
        VStack {
            Text("Analysis Result")
                .font(.largeTitle)
                .padding()
            
            // Display the result text received from ViewController
            Text(resultText)
                .font(.title)
                .padding()

            Button(action: {
                // Dismiss the results view
                if let presentingVC = UIApplication.shared.windows.first?.rootViewController {
                    presentingVC.dismiss(animated: true, completion: nil)
                }
            }) {
                Text("Take Another Photo")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
