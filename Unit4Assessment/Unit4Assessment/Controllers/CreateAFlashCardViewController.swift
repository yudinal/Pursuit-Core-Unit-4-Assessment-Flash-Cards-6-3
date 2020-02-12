//
//  ViewController.swift
//  Unit4Assessment
//
//  Created by Alex Paul on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

enum FlashCardState {
  case newFlashCard
  case existingFlashCard
}

class CreateAFlashCardViewController: UIViewController {
    
private let createFlashCardView = CreateFlashCardView()
    private var flashCard: FlashCard?
     public var dataPersistence: DataPersistence<FlashCard>!
    public private(set) var flashCardState = FlashCardState.newFlashCard
    
    override func loadView() {
           view = createFlashCardView
       }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    createFlashCardView.titleTextView.delegate = self
    createFlashCardView.descriptionTextField.delegate = self
    createFlashCardView.moreDescriptionTextField.delegate = self
    updateUI()
    
  }
    private func updateUI() {
        if let flashCard = flashCard {
            self.flashCard = flashCard
            createFlashCardView.titleTextView.text = flashCard.quizTitle
            createFlashCardView.descriptionTextField.text = flashCard.facts.randomElement()
            createFlashCardView.moreDescriptionTextField.text = flashCard.facts.randomElement()
            flashCardState = .existingFlashCard
        } else {
            flashCard = FlashCard(id: "", quizTitle: "", facts: [""])
            flashCardState = .newFlashCard
        }
        
    }

}

extension CreateAFlashCardViewController: UITextFieldDelegate, UITextViewDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {

    textField.resignFirstResponder()

//    flashCard?.presentAllFacts().randomElement() = textField.text ?? "no event name"

    return true
  }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {

       textView.resignFirstResponder()

      flashCard?.quizTitle = textView.text ?? "no event name"

       return true
     }
}
