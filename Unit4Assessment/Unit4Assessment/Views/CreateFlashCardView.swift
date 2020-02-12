//
//  CreateFlashCardView.swift
//  Unit4Assessment
//
//  Created by Lilia Yudina on 2/12/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateFlashCardView: UIView {
    
    public lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemPink
        return textView
    }()
    
    public lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    public lazy var moreDescriptionTextField: UITextField = {
         let textField = UITextField()
         textField.backgroundColor = .lightGray
         return textField
     }()
    
    override init(frame: CGRect) {
      super.init(frame: UIScreen.main.bounds)
      commonInit()
    }
    
    required init?(coder: NSCoder) {
      super.init(coder: coder)
      commonInit()
    }
    
    private func commonInit() {
      setupTitleTextViewConstraints()
        setupDescriptionTextFieldConstraints()
        setupMoreDescriptionTextFieldConstraints()
     }
    
    private func setupTitleTextViewConstraints() {
        addSubview(titleTextView)
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo:  safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleTextView.heightAnchor.constraint(equalToConstant: 50),
            titleTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupDescriptionTextFieldConstraints() {
        addSubview(descriptionTextField)
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextField.topAnchor.constraint(equalTo:  titleTextView.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 100),
            descriptionTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupMoreDescriptionTextFieldConstraints() {
          addSubview(moreDescriptionTextField)
          moreDescriptionTextField.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              moreDescriptionTextField.topAnchor.constraint(equalTo:  descriptionTextField.bottomAnchor, constant: 20),
              moreDescriptionTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
              moreDescriptionTextField.heightAnchor.constraint(equalToConstant: 100),
              moreDescriptionTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
          ])
      }
    
    
}
