//
//  LoadingView.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 29/08/23.
//

import UIKit

/// A custom UIView to handle loading and error states.
class LoadingView: UIView {
    
    // MARK: - UI Elements
    
    /// UIActivityIndicatorView for showing loading state.
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    /// UILabel for displaying error messages.
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "An error occurred"
        label.isHidden = true
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// UIButton for retrying failed operations.
    let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry", for: .normal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    
    /// Initializes the view and sets up its UI.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIElements()
        setupConstraints()
    }
    
    /// Required initializer, not implemented.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    /// Sets up the UI elements in the view.
    private func setupUIElements() {
        addSubview(activityIndicator)
        addSubview(errorLabel)
        addSubview(retryButton)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Sets up the constraints for the UI elements.
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
    
    // MARK: - UI Update Methods
    
    /// Displays the loading indicator and hides error messages and retry button.
    func showLoading() {
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
        retryButton.isHidden = true
    }
    
    /// Displays the error message and shows the retry button.
    /// - Parameter error: The error to display.
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
    
    /// Hides the loading indicator and error messages.
    func hide() {
        activityIndicator.stopAnimating()
        self.isHidden = true
    }
}
