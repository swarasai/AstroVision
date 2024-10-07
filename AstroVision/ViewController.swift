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
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.isHidden = true // Start hidden
        return button
    }()
    
    private let quizButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Take a Quiz", for: .normal)
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
        print("ViewController: viewDidLoad() called")
        
        // Setup view background color
        view.backgroundColor = UIColor(red: 0.784, green: 0.894, blue: 0.937, alpha: 1)
        
        // Add buttons to the view
        view.addSubview(learnButton)
        view.addSubview(quizButton)
        
        // Setup splash screen and constraints
        setupSplashScreen()
        setupConstraints()
        
        // Button Actions
        learnButton.addTarget(self, action: #selector(navigateToLearn), for: .touchUpInside)
        quizButton.addTarget(self, action: #selector(navigateToQuiz), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        learnButton.translatesAutoresizingMaskIntoConstraints = false
        quizButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            learnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            learnButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            learnButton.widthAnchor.constraint(equalToConstant: 250),
            learnButton.heightAnchor.constraint(equalToConstant: 44),
            
            quizButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quizButton.topAnchor.constraint(equalTo: learnButton.bottomAnchor, constant: 20),
            quizButton.widthAnchor.constraint(equalToConstant: 250),
            quizButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // Set initial visibility
        learnButton.alpha = 0 // Start invisible
        quizButton.alpha = 0 // Start invisible
        learnButton.isHidden = true
        quizButton.isHidden = true

        print("ViewController: setupConstraints() completed")
    }
    
    // Setup and display the splash screen
    private func setupSplashScreen() {
        print("ViewController: setupSplashScreen() called")

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
            print("ViewController: SplashScreenView added to the view")
        }
    }

    // Call this function to navigate after the splash screen
    func navigateAfterSplash() {
        print("ViewController: navigateAfterSplash() called")
        splashScreenHostingController?.willMove(toParent: nil)
        splashScreenHostingController?.view.removeFromSuperview()
        splashScreenHostingController?.removeFromParent()

        // Show the buttons
        learnButton.isHidden = false
        quizButton.isHidden = false

        // Optionally, animate the buttons
        UIView.animate(withDuration: 0.5) {
            self.learnButton.alpha = 1
            self.quizButton.alpha = 1
        }
    }

    // Navigation to LearnView
    @objc private func navigateToLearn() {
        let learnView = LearnView() // Ensure this view is defined
        navigationController?.pushViewController(learnView, animated: true)
    }

    // Navigation to QuizView
    @objc private func navigateToQuiz() {
        let quizView = QuizView() // Ensure this view is defined
        navigationController?.pushViewController(quizView, animated: true)
    }
}
