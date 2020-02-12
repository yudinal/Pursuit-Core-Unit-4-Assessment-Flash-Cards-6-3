//
//  FlashCardCollectionViewController.swift
//  Unit4Assessment
//
//  Created by Lilia Yudina on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class FlashCardCollectionViewController: UIViewController {
    
    private let flashCardCollectionControllerView = FlashCardCollectionControllerView()
 
     public var dataPersistence: DataPersistence<FlashCard>!
     
     public var userPreference: UserPreference!
    
    private var flashCards = [FlashCard]() {
      didSet {
        DispatchQueue.main.async {
    self.flashCardCollectionControllerView.collectionView.reloadData()
        }
      }
    }

    override func loadView() {
      view = flashCardCollectionControllerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        flashCardCollectionControllerView.collectionView.dataSource = self
        flashCardCollectionControllerView.collectionView.delegate = self
        
        flashCardCollectionControllerView.collectionView.register(CollectionFlashCardViewCell.self, forCellWithReuseIdentifier: "collectionFlashCardCell")
        
     loadFlashCards()

    }
    
    private func loadFlashCards() {
        do {
        flashCards = try FlashCardService.fetchFlashCards()
    } catch {
     print("error fetching flash cards: \(error)")
    }
    }

}

extension FlashCardCollectionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return flashCards.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionFlashCardCell", for: indexPath) as? CollectionFlashCardViewCell else {
      fatalError("could not downcast to CollectionFlashCardViewCell")
    }
    let flashCard = flashCards[indexPath.row]
    cell.configreCell(for: flashCard)
    cell.backgroundColor = .systemBackground
    return cell
  }
}

extension FlashCardCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let maxSize: CGSize = UIScreen.main.bounds.size
    let itemWidth: CGFloat = maxSize.width
    let itemHeight: CGFloat = maxSize.height * 0.30
    return CGSize(width: itemWidth, height: itemHeight)
  }
  
}

extension FlashCardCollectionViewController: UserPreferenceDelegate {
  func didChangeNewsSection(_ userPreference: UserPreference, sectionName: String) {
    loadFlashCards()
  }
}
