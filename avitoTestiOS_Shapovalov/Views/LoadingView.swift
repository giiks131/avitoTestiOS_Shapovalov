//
//  LoadingView.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 29/08/23.
//

import UIKit

// A custom UIView to handle loading and error states
class LoadingView: UIView {
    
    // UI Elements
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "An error occurred"
        label.isHidden = true
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry", for: .normal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIElements()
        setupConstraints()
    }
    
    // Required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup UI Elements
    private func setupUIElements() {
        addSubview(activityIndicator)
        addSubview(errorLabel)
        addSubview(retryButton)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            retryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 16)
        ])
    }
    
    // Show loading state
    func showLoading() {
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
        retryButton.isHidden = true
    }
    
    // Show error state
    func showError(_ error: Error?) {
        activityIndicator.stopAnimating()

        if let networkError = error as? NetworkError {
            errorLabel.text = networkError.errorDescription
        } else {
            errorLabel.text = "An unknown error occurred"
        }

        errorLabel.isHidden = false
        retryButton.isHidden = false
    }
    
    // Hide loading view
    func hide() {
        activityIndicator.stopAnimating()
        self.isHidden = true
    }
}
