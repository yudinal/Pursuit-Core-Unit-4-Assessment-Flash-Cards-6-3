//
//  CollectionFlashCardViewCell.swift
//  Unit4Assessment
//
//  Created by Lilia Yudina on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence


protocol CollectionFlashCardViewCellDelegate: AnyObject {
  func didSelectPlusButton(_ collectionFlashCardViewCell: CollectionFlashCardViewCell, flashCard: FlashCard)
}

class CollectionFlashCardViewCell: UICollectionViewCell {
    
  weak var delegate: CollectionFlashCardViewCellDelegate?
  private var currentFlashCard: FlashCard!
    public var dataPersistance: DataPersistence<FlashCard>!
  
  private lazy var longPressGesture: UILongPressGestureRecognizer = {
    let gesture = UILongPressGestureRecognizer()
    gesture.addTarget(self, action: #selector(didLongPress(_:)))
    return gesture
  }()

  public lazy var plusButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
    button.addTarget(self, action: #selector(plusButtonPressed(_:)), for: .touchUpInside)
    return button
  }()
  
  public lazy var flashCardTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .title2)
    label.text = "Flash Card Title"
    label.numberOfLines = 0
    return label
  }()
  
  public lazy var flashCardTextView: UITextView = {
    let textView = UITextView()
    textView.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 17)
    textView.textColor = UIColor.darkText
    textView.isEditable = false
    textView.isSelectable = false
    return textView
  }()
  
  private var isShowingTextView = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
  setupPlusButtonConstraints()
    setupFlashCardTitleConstraints()
    setupFlashCardTextViewConstraints()
    layer.borderColor = UIColor.systemGray.cgColor
    layer.borderWidth = 1.0
    addGestureRecognizer(longPressGesture)
  }
  
  @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
    guard let currentFlashCard = currentFlashCard else { return }
    if gesture.state == .began || gesture.state == .changed {
      return
    }
    
    isShowingTextView.toggle()
    flashCardTextView.text = currentFlashCard.presentAllFacts()
    animate()
    }
  
  private func animate() {
    let duration: Double = 1.0
    if isShowingTextView {
      UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
        self.flashCardTextView.alpha = 1.0
        self.flashCardTextView.isHidden = false
        self.flashCardTitle.alpha = 0.0
      }, completion: nil)
    } else {
      UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
        self.flashCardTextView.alpha = 0.0
        self.flashCardTitle.alpha = 1.0
         self.flashCardTextView.isHidden = true
      }, completion: nil)
    }
  }
  
  @objc private func plusButtonPressed(_ sender: UIButton) {
    delegate?.didSelectPlusButton(self, flashCard: currentFlashCard)
      
        guard let flashCard = currentFlashCard else {
            return
        }
        do {
            try dataPersistance.createItem(flashCard)
        } catch {
            print("could not save \(error)")
        }
        
        sender.isEnabled = false
        showAlert(title: "Save", message: "This Flash Card has been added to your flash cards!", completion: nil)
    }
  
  
  private func setupPlusButtonConstraints() {
    addSubview(plusButton)
    plusButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      plusButton.topAnchor.constraint(equalTo: topAnchor),
      plusButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      plusButton.heightAnchor.constraint(equalToConstant: 44),
      plusButton.widthAnchor.constraint(equalTo: plusButton.heightAnchor)
    ])
  }
  
  private func setupFlashCardTitleConstraints() {
    addSubview(flashCardTitle)
    flashCardTitle.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      flashCardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      flashCardTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
      flashCardTitle.topAnchor.constraint(equalTo: plusButton.bottomAnchor),
      flashCardTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  private func setupFlashCardTextViewConstraints() {
    addSubview(flashCardTextView)
    flashCardTextView.isHidden = true
    flashCardTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      flashCardTextView.topAnchor.constraint(equalTo: plusButton.bottomAnchor),
      flashCardTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      flashCardTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
      flashCardTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
    ])
  }
  
  public func configreCell(for collectionFlashCard: FlashCard) {
    currentFlashCard = collectionFlashCard
    flashCardTitle.text = collectionFlashCard.quizTitle
  }
}

extension CollectionFlashCardViewCell {
    func showAlert(title:String? = nil, message: String? = nil, completion: ((UIAlertAction) -> Void)? = nil){
    
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
    //present(alertVC, animated: true, completion: nil)
        
    }
}
