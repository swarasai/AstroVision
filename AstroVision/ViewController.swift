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
    
    // Define buttons
    private let learnButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Learn about Exoplanets!", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.isHidden = true // Start hidden
        return button
    }()
    
    private let uploadPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload a Photo", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.isHidden = true // Start hidden
        return button
    }()
    
    private var splashScreenHostingController: UIHostingController<SplashScreenView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.784, green: 0.894, blue: 0.937, alpha: 1)
        
        // Add buttons to the view
        view.addSubview(learnButton)
        view.addSubview(uploadPhotoButton)
        
        // Setup splash screen and constraints
        setupSplashScreen()
        setupConstraints()
        
        // Button Actions
        learnButton.addTarget(self, action: #selector(navigateToLearn), for: .touchUpInside)
        uploadPhotoButton.addTarget(self, action: #selector(uploadPhotoTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        learnButton.translatesAutoresizingMaskIntoConstraints = false
        uploadPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            learnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            learnButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            learnButton.widthAnchor.constraint(equalToConstant: 250),
            learnButton.heightAnchor.constraint(equalToConstant: 44),
            
            uploadPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadPhotoButton.topAnchor.constraint(equalTo: learnButton.bottomAnchor, constant: 20),
            uploadPhotoButton.widthAnchor.constraint(equalToConstant: 250),
            uploadPhotoButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        learnButton.alpha = 0 // Start invisible
        learnButton.isHidden = true
        uploadPhotoButton.alpha = 0 // Start invisible
        uploadPhotoButton.isHidden = true
    }
    
    // Splash Screen Setup
    private func setupSplashScreen() {
        let splashView = SplashScreenView(
            navigateToMain: { [weak self] in
                self?.navigateAfterSplash() // Call the navigation function
            }
        )
        
        splashScreenHostingController = UIHostingController(rootView: splashView)
        
        if let hostingController = splashScreenHostingController {
            addChild(hostingController)
            hostingController.view.frame = view.bounds
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }
    }
    
    func navigateAfterSplash() {
        splashScreenHostingController?.willMove(toParent: nil)
        splashScreenHostingController?.view.removeFromSuperview()
        splashScreenHostingController?.removeFromParent()
        
        // Show the buttons
        learnButton.isHidden = false
        uploadPhotoButton.isHidden = false
        
        UIView.animate(withDuration: 0.5) {
            self.learnButton.alpha = 1
            self.uploadPhotoButton.alpha = 1
        }
    }
    
    // Navigation to LearnView
    @objc private func navigateToLearn() {
        let learnView = LearnView() // Ensure this view is defined
        navigationController?.pushViewController(learnView, animated: true)
    }
    
    // Handle photo upload button tap
    @objc private func uploadPhotoTapped() {
        let photoCaptureView = PhotoCaptureView { image in
            if let capturedImage = image {
                self.analyzeImage(image: capturedImage) // Analyze the captured image
            } else {
                print("Photo capture canceled or failed.")
            }
        }
        
        let hostingController = UIHostingController(rootView: photoCaptureView)
        present(hostingController, animated: true, completion: nil)
    }
    
    private func analyzeImage(image: UIImage?) {
        guard let buffer = image?.resize(size: CGSize(width: 224, height: 224))?.getCVPixelBuffer() else {
            DispatchQueue.main.async {
                self.showResultPage(resultText: "Failed to process image.")
            }
            return
        }

        do {
            let config = MLModelConfiguration()
            let model = try exoplanets_1(configuration: config)
            let input = exoplanets_1Input(image: buffer)
            let output = try model.prediction(input: input)
            let planetType = output.target
            let message = getExoplanetMessage(for: planetType)

            DispatchQueue.main.async {
                self.dismiss(animated: true) {
                    self.showResultPage(resultText: message) // Navigate to the result page
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.dismiss(animated: true) {
                    self.showResultPage(resultText: "Error analyzing image.") // Navigate to error result page
                }
            }
        }
    }

    
    // Display the classification result
    private func showResult(resultText: String) {
        let alert = UIAlertController(title: "Analysis Result", message: resultText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Get the appropriate message based on the exoplanet type
    private func getExoplanetMessage(for planetType: String) -> String {
        switch planetType.lowercased() {
        case "gas giant":
            return "This is a Gas Giant, a large planet primarily composed of hydrogen and helium, such as Jupiter and Saturn."
        case "neptunian":
            return "This is a Neptunian planet, similar in size and composition to Neptune and Uranus."
        case "super-earth":
            return "This is a Super-Earth, a planet larger than Earth but smaller than Uranus and Neptune."
        case "terrestrial":
            return "This is a Terrestrial planet, rocky like Earth, Mars, Venus, and Mercury."
        default:
            return "Unable to determine exoplanet."
        }
    }
    private func showResultPage(resultText: String) {
        let resultView = ResultView(resultText: resultText)
        let hostingController = UIHostingController(rootView: resultView)
        self.navigationController?.pushViewController(hostingController, animated: true)
    }

}
