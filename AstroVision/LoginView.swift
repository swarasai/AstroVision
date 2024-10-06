//
//  LoginView.swift
//  AstroVision
//
//  Created by Swarasai Mulagari on 10/6/24.
//

import SwiftUI

struct LoginView: View {
    let onCapturePhoto: () -> Void
    let onUploadPhoto: () -> Void

    var body: some View {
        ZStack {
            Color(red: 0.784, green: 0.894, blue: 0.937) // Lighter sky blue
                .edgesIgnoringSafeArea(.all) // Ensure it covers the entire screen
            
            VStack {
                Spacer()
                
                Text("AstroVision")
                    .font(.custom("Avenir Next Bold", size: 60))
                    .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.5))
                    .padding(.bottom, 20)

                // Button to take a photo
                Button(action: onCapturePhoto) {
                    Text("Take a Photo")
                        .font(.custom("Avenir Next Bold", size: 20))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom, 10)
                }
                
                // Button to upload a photo from the library
                Button(action: onUploadPhoto) {
                    Text("Upload a Photo")
                        .font(.custom("Avenir Next Bold", size: 20))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
        }
    }
}
