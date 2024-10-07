//
//  SplashScreenView.swift
//  AstroVision
//
//  Created by Swarasai Mulagari on 10/6/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var scale: CGFloat = 0.5
    @State private var hideLogo = false

    // Callback for navigation
    let navigateToMain: () -> Void

    var body: some View {
        ZStack {
            Color(red: 0.784, green: 0.894, blue: 0.937) // Background color
                .edgesIgnoringSafeArea(.all) // Covers the entire screen

            VStack {
                if !hideLogo {
                    Image("logo") // Ensure you have this image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(scale)
                        .frame(width: 300, height: 300)
                        .offset(y: -30)
                        .padding()
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                scale = 1.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    hideLogo = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    navigateToMain() // Call the navigation function here
                                }
                            }
                        }
                }
            }
        }
    }
}
