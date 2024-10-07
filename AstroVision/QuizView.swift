//
//  QuizView.swift
//  AstroVision
//
//  Created by Swarasai Mulagari on 10/6/24.
//

import UIKit

// Step 1: Define the model for the questions
struct QuizQuestion {
    let question: String
    let options: [String]
    let correctAnswer: String
}

class QuizView: UIViewController {
    
    // Quiz questions
    let questions: [QuizQuestion] = [
        QuizQuestion(question: "What is an exoplanet?", options: ["A celestial body that orbits a star", "A satellite orbiting Earth", "A moon of a gas giant", "A planet in our solar system"], correctAnswer: "A celestial body that orbits a star"),
        QuizQuestion(question: "When did the exploration of exoplanets begin?", options: ["1980", "1992", "2000", "2010"], correctAnswer: "1992"),
        QuizQuestion(question: "What is the name of the first exoplanets discovered?", options: ["Two planets orbiting a red giant", "Two planets orbiting a pulsar", "Two planets orbiting the Sun", "Two planets orbiting a black hole"], correctAnswer: "Two planets orbiting a pulsar"),
        QuizQuestion(question: "What method involves measuring the dimming of a star’s light to detect an exoplanet?", options: ["Radial velocity technique", "Transit method", "Direct imaging", "Gravitational lensing"], correctAnswer: "Transit method"),
        QuizQuestion(question: "What does the radial velocity technique measure?", options: ["The brightness of a star", "The gravitational influence of a planet", "The atmospheric composition of a planet", "The distance to the nearest star"], correctAnswer: "The gravitational influence of a planet"),
        QuizQuestion(question: "Why is characterizing exoplanets important?", options: ["To understand their temperatures", "To analyze their orbits", "To determine their potential for habitability", "To discover new stars"], correctAnswer: "To determine their potential for habitability"),
        QuizQuestion(question: "What tool do astronomers use to analyze the light filtered through an exoplanet's atmosphere?", options: ["Spectroscopy", "Microscopy", "Photometry", "Radiometry"], correctAnswer: "Spectroscopy"),
        QuizQuestion(question: "What are habitable zones?", options: ["Areas in space with no stars", "Regions where liquid water may exist", "Zones where no planets can exist", "Areas populated by alien life"], correctAnswer: "Regions where liquid water may exist"),
        QuizQuestion(question: "What does the ongoing research of exoplanets enhance our knowledge of?", options: ["Galactic warfare", "Planetary formation and evolution", "Space travel", "Time travel"], correctAnswer: "Planetary formation and evolution"),
        QuizQuestion(question: "What potential questions does the study of exoplanets raise?", options: ["The likelihood of extraterrestrial life", "The speed of light", "The formation of black holes", "The origin of dark matter"], correctAnswer: "The likelihood of extraterrestrial life")
    ]
    
    var userAnswers: [String?] = []
    var score: Int = 0
    
    // Create UI elements
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let submitButton = UIButton(type: .system)
    private let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.784, green: 0.894, blue: 0.937, alpha: 1)
        
        setupUI()
        displayQuestions()
    }

    private func setupUI() {
        // Setup scroll view
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Setup stack view
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor), // Adjusted to connect to scrollView
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Setup result label
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        resultLabel.textColor = .black // Change text color to black
        stackView.addArrangedSubview(resultLabel)
        
        // Setup submit button
        submitButton.setTitle("Submit Answers", for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 20) // Increase font size
        submitButton.backgroundColor = UIColor.systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action: #selector(submitAnswers), for: .touchUpInside)

        view.addSubview(submitButton) // Keep button outside of stackView
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20), // Add padding from bottom
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 60) // Set button height
        ])
    }


    private func displayQuestions() {
        userAnswers = Array(repeating: nil, count: questions.count)
        
        for (index, question) in questions.enumerated() {
            let questionLabel = UILabel()
            questionLabel.text = "\(index + 1). \(question.question)"
            questionLabel.textColor = .black
            questionLabel.font = UIFont(name: "AvenirNext-Bold", size: 18)
            questionLabel.textAlignment = .center
            questionLabel.numberOfLines = 0
            
            stackView.addArrangedSubview(questionLabel)
            
            let radioButtonStack = UIStackView()
            radioButtonStack.axis = .vertical
            radioButtonStack.spacing = 10
            
            for option in question.options {
                let optionButton = UIButton(type: .system)
                optionButton.setTitle(option, for: .normal)
                optionButton.setTitleColor(.black, for: .normal)
                optionButton.titleLabel?.font = UIFont(name: "AvenirNext", size: 16)
                optionButton.tag = index // Set tag to question index
                optionButton.contentHorizontalAlignment = .left
                optionButton.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)

                // Add radio button image
                let radioButton = UIButton(type: .custom)
                radioButton.setImage(UIImage(systemName: "circle"), for: .normal)
                radioButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
                radioButton.tag = index // Set tag to question index
                radioButton.isUserInteractionEnabled = false // Disable interaction for the radio button

                let optionStack = UIStackView()
                optionStack.axis = .horizontal
                optionStack.spacing = 10
                
                // Add radio button and option button to the stack
                optionStack.addArrangedSubview(radioButton)
                optionStack.addArrangedSubview(optionButton)
                
                // Store the radio button in a way we can access it later
                radioButtonStack.addArrangedSubview(optionStack)
            }
            
            stackView.addArrangedSubview(radioButtonStack)
        }
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        let questionIndex = sender.tag
        
        // Store the user's answer
        userAnswers[questionIndex] = sender.title(for: .normal)
        
        // Update the radio button states
        updateRadioButtonStates(for: questionIndex, selectedAnswer: sender.title(for: .normal) ?? "")
    }
    
    private func updateRadioButtonStates(for selectedIndex: Int, selectedAnswer: String) {
        // Iterate through all options to set the selected state of the radio buttons
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            if let stack = view as? UIStackView, index > 1 { // Ignore the first two elements (results label)
                for (optionIndex, optionView) in stack.arrangedSubviews.enumerated() {
                    if let optionStack = optionView as? UIStackView, let radioButton = optionStack.arrangedSubviews.first as? UIButton, let optionButton = optionStack.arrangedSubviews.last as? UIButton {
                        // Update the radio button state based on the user's answer
                        if index - 2 == selectedIndex { // Current question
                            radioButton.isSelected = (userAnswers[selectedIndex] == optionButton.title(for: .normal))
                        } else {
                            // Reset previous question's radio buttons
                            radioButton.isSelected = false
                        }
                    }
                }
            }
        }
    }

    @objc private func submitAnswers() {
        score = 0
        for (index, answer) in userAnswers.enumerated() {
            if let answer = answer, answer == questions[index].correctAnswer {
                score += 1
            }
        }
        
        let results = "Your score: \(score) out of \(questions.count)"
        resultLabel.text = results
        resultLabel.isHidden = false
    }
}

