//
//  LearnView.swift
//  AstroVision
//
//  Created by Swarasai Mulagari on 10/6/24.
//

import UIKit

class LearnView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.784, green: 0.894, blue: 0.937, alpha: 1)

        // Create a UILabel for the title
        let titleLabel = UILabel()
        titleLabel.text = "Learn about Exoplanets!"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "AvenirNext-Bold", size: 24) // Set font to Avenir Next Bold
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        // Create a UITextView for the content
        let contentTextView = UITextView()
        contentTextView.text = """
        Exoplanets, or extrasolar planets, are celestial bodies that orbit stars outside our solar system, and their study has transformed our understanding of the universe. The exploration of exoplanets began in earnest with the discovery of two planets orbiting a pulsar in 1992. Since then, advancements in technology and observational techniques have led to the identification of thousands of exoplanets across diverse star systems. Scientists use various methods to find these distant worlds, including the transit method, where the dimming of a star’s light indicates a planet passing in front of it, and the radial velocity technique, which measures the gravitational influence of a planet on its host star. This expanding catalog of exoplanets provides researchers with a wealth of data to analyze and compare against our own solar system.

        Characterizing exoplanets is crucial for understanding their atmospheres, compositions, and potential for habitability. Once a planet is detected, astronomers use tools like spectroscopy to analyze the light filtered through an exoplanet's atmosphere during transits, revealing its chemical makeup. Some exoplanets are found in their stars' habitable zones, where conditions may allow liquid water to exist—an essential ingredient for life. This ongoing research not only enhances our knowledge of planetary formation and evolution but also raises intriguing questions about the potential for extraterrestrial life. As we continue to refine our detection methods and characterization techniques, the study of exoplanets holds the promise of groundbreaking discoveries, deepening our understanding of the universe and our place within it.
        """
        contentTextView.textColor = .black // Set text color
        contentTextView.font = UIFont(name: "AvenirNext-Regular", size: 16) // Set font to Avenir Next Regular
        contentTextView.isEditable = false // Make it non-editable
        contentTextView.backgroundColor = .clear // Set background color to clear
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(contentTextView)

        // Set up constraints for the title label and content text view
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            contentTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20) // Prevents overlap with safe area
        ])

        // Optional: Set content inset for padding
        contentTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
