//
//  ViewController.swift
//  AstroVision
//
//  Created by Swarasai Mulagari on 10/6/24.
//

import SwiftUI
import UIKit

class ViewController: UIViewController {

    private var splashScreenHostingController: UIHostingController<SplashScreenView>?
    private var loginHostingController: UIHostingController<LoginView>?
    private var photoCaptureHostingController: UIHostingController<PhotoCaptureView>?

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
    private func analyzeImage(image: UIImage) {
        // Image analysis logic here
    }
}
