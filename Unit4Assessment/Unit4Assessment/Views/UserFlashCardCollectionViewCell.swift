//
//  UserCardCollectionViewCell.swift
//  Unit4Assessment
//
//  Created by Lilia Yudina on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol UserCardCollectionViewCellDelegate: AnyObject {
  func didSelectMoreButton(_ userCardCollectionViewCellCell: UserFlashCardCollectionViewCell, flashCard: FlashCard)
}

class UserFlashCardCollectionViewCell: UICollectionViewCell {
    
  weak var delegate: UserCardCollectionViewCellDelegate?
  private var currentFlashCard: FlashCard!
  
  private lazy var longPressGesture: UILongPressGestureRecognizer = {
    let gesture = UILongPressGestureRecognizer()
    gesture.addTarget(self, action: #selector(didLongPress(_:)))
    return gesture
  }()

  public lazy var moreButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
    button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
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
  setupMoreButtonConstraints()
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
        self.flashCardTextView.isHidden = true
        self.flashCardTitle.alpha = 1.0
      }, completion: nil)
    }
  }
  
  @objc private func moreButtonPressed(_ sender: UIButton) {
    delegate?.didSelectMoreButton(self, flashCard: currentFlashCard)
  }
  
  private func setupMoreButtonConstraints() {
    addSubview(moreButton)
    moreButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      moreButton.topAnchor.constraint(equalTo: topAnchor),
      moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      moreButton.heightAnchor.constraint(equalToConstant: 44),
     moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor)
    ])
  }
  
  private func setupFlashCardTitleConstraints() {
    addSubview(flashCardTitle)
    flashCardTitle.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      flashCardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      flashCardTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
      flashCardTitle.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
      flashCardTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  private func setupFlashCardTextViewConstraints() {
    addSubview(flashCardTextView)
    flashCardTextView.isHidden = true
    flashCardTextView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      flashCardTextView.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
      flashCardTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
      flashCardTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
      flashCardTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
  
  public func configreCell(for userCardCollection: FlashCard) {
    currentFlashCard = userCardCollection
    flashCardTitle.text = userCardCollection.quizTitle
  }
}

