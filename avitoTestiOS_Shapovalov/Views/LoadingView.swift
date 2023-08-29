//
//  LoadingView.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 29/08/23.
//

import UIKit

class LoadingView: UIView {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "An error occurred"
        label.isHidden = true
        label.textColor = .red
        return label
    }()
    let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry", for: .normal)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(activityIndicator)
        addSubview(errorLabel)
        addSubview(retryButton)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            retryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 16)
        ])
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
        retryButton.isHidden = true
    }
    
    func showError() {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = false
        retryButton.isHidden = false
    }
    
    func hide() {
        activityIndicator.stopAnimating()
        self.isHidden = true
    }
}
