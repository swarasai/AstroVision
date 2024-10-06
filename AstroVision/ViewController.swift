//
//  ViewController.swift
//  AstroVision
//
//  Created by Swarasai Mulagari on 10/6/24.
//

import SwiftUI
import UIKit
import CoreML

class ViewController: UIViewController {

    private var splashScreenHostingController: UIHostingController<SplashScreenView>?
    private var loginHostingController: UIHostingController<LoginView>?
    private var photoCaptureHostingController: UIHostingController<PhotoCaptureView>?
    private var resultsHostingController: UIHostingController<ResultsView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        showSplashScreen()
    }

    // Show the splash screen
    private func showSplashScreen() {
        let splashScreenView = SplashScreenView(
            onLogin: { [weak self] in
                self?.navigateToLogin()  // Implement the logic for login navigation
            },
            onCapturePhoto: { [weak self] in
                self?.navigateToPhotoCapture()  // Navigate to photo capture
            },
            onUploadPhoto: { [weak self] in
                self?.navigateToPhotoUpload()  // Navigate to photo upload
            }
        )

        splashScreenHostingController = UIHostingController(rootView: splashScreenView)

        if let hostingController = splashScreenHostingController {
            addChild(hostingController)
            hostingController.view.frame = view.bounds
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }
    }

    // Navigate to login
    private func navigateToLogin() {
        let loginView = LoginView(
            onCapturePhoto: { [weak self] in
                self?.navigateToPhotoCapture()
            },
            onUploadPhoto: { [weak self] in
                self?.navigateToPhotoUpload()
            }
        )

        splashScreenHostingController?.view.removeFromSuperview()
        splashScreenHostingController?.removeFromParent()

        let loginHostingController = UIHostingController(rootView: loginView)
        self.loginHostingController = loginHostingController

        addChild(loginHostingController)
        loginHostingController.view.frame = view.bounds
        view.addSubview(loginHostingController.view)
        loginHostingController.didMove(toParent: self)
    }

    // Navigate to photo capture
    private func navigateToPhotoCapture() {
        let photoCaptureView = PhotoCaptureView(onImageCaptured: { [weak self] image in
            if let unwrappedImage = image {
                DispatchQueue.global(qos: .userInitiated).async {
                    self?.analyzeImage(image: unwrappedImage)
                }
            }
        }, sourceType: .camera)

        photoCaptureHostingController = UIHostingController(rootView: photoCaptureView)

        if let hostingController = photoCaptureHostingController {
            present(hostingController, animated: true, completion: nil)
        }
    }

    // Navigate to photo upload
    private func navigateToPhotoUpload() {
        let photoCaptureView = PhotoCaptureView(onImageCaptured: { [weak self] image in
            if let unwrappedImage = image {
                DispatchQueue.global(qos: .userInitiated).async {
                    self?.analyzeImage(image: unwrappedImage)
                }
            }
        }, sourceType: .photoLibrary)

        photoCaptureHostingController = UIHostingController(rootView: photoCaptureView)

        if let hostingController = photoCaptureHostingController {
            present(hostingController, animated: true, completion: nil)
        }
    }

    // Analyze the captured or uploaded image
    private func analyzeImage(image: UIImage?) {
        guard let buffer = image?.resize(size: CGSize(width: 224, height: 224))?.getCVPixelBuffer() else {
            DispatchQueue.main.async {
                self.showResult(resultText: "Failed to process image.")
            }
            return
        }

        do {
            let config = MLModelConfiguration()
            let model = try SpaceLovers_1(configuration: config)
            let input = SpaceLovers_1Input(image: buffer)

            let output = try model.prediction(input: input)
            let text = output.target
            let message = self.getMessage(for: text)

            DispatchQueue.main.async {
                self.navigateToResults(resultText: message)
                // Dismiss the photo capture view before showing results
                self.photoCaptureHostingController?.dismiss(animated: true, completion: nil)
            }
        } catch {
            DispatchQueue.main.async {
                self.showResult(resultText: "Error analyzing image.")
            }
        }
    }

    // Navigate to results view
    private func navigateToResults(resultText: String) {
        let resultsView = ResultsView(resultText: resultText) // Pass the result message
        let resultsHostingController = UIHostingController(rootView: resultsView)

        self.present(resultsHostingController, animated: true, completion: nil)
    }

    // Function to display a simple result in case of failure
    private func showResult(resultText: String) {
        let alert = UIAlertController(title: "Result", message: resultText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // Get a meaningful message from the prediction
    private func getMessage(for text: String) -> String {
        switch text {
        case "Constellation":
            return "This is a constellation."
        case "Cosmos space":
            return "This is the cosmos."
        case "galaxies":
            return "This is a galaxy."
        case "nebula":
            return "This is a nebula."
        case "planets":
            return "This is a planet."
        case "stars":
            return "This is a star."
        default:
            return "Unknown Space Object."
        }
    }
}
