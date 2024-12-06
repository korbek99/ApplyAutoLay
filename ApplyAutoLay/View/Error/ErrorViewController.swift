//
//  ErrorViewController.swift
//  ApplyAutoLay
//
//  Created by Jose Preatorian on 04-12-24.
//

import UIKit

class ErrorViewController: UIViewController {
    var errorMessage: String?
    
    private lazy var lblErrorTitle: UILabel = {
         let label: UILabel = .init()
         label.lineBreakMode = NSLineBreakMode.byWordWrapping
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
   private lazy var lblError: UILabel = {
        let label: UILabel = .init()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        configureMessage()
    }
    
    private func configureMessage() {
 
        lblErrorTitle.font = UIFont.systemFont(ofSize: 25.0)
        lblErrorTitle.textColor = UIColor.orange
        lblErrorTitle.numberOfLines = 0
        lblErrorTitle.lineBreakMode = .byWordWrapping

        lblError.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblError.textColor = UIColor.gray
        lblError.numberOfLines = 0

        lblErrorTitle.text = NSLocalizedString("ERROR_TITLE", comment: "Title for the error message")
        lblError.text = errorMessage ?? NSLocalizedString("ERROR_TITLE_EXP", comment: "Title for the error message")   
    }
    
    private func setupLabel() {
        view.backgroundColor = .white
        view.addSubview(lblErrorTitle)
        view.addSubview(lblError)
        
        NSLayoutConstraint.activate([
            lblErrorTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            lblErrorTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            lblErrorTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
  
            lblError.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblError.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lblError.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            lblError.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }

}
