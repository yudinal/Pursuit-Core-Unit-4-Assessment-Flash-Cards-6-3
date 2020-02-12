//
//  UserCardCollectionController.swift
//  Unit4Assessment
//
//  Created by Lilia Yudina on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class UserCardCollectionController: UIViewController {
    
    private let userCardCollectionView = UserCardCollectionView()
    public var dataPersistence: DataPersistence<FlashCard>!
    
    private var userFlashCards = [FlashCard]() {
        didSet {
            userCardCollectionView.collectionView.reloadData()
            if userFlashCards.isEmpty {
                userCardCollectionView.collectionView.backgroundView = EmptyView(title: "User Flash Cards", message: "There are currently no saved flash cards. Start browsing by tapping on the Flash Card icon.")
            } else {
                userCardCollectionView.collectionView.backgroundView = nil
            }
        }
    }
    
    override func loadView() {
        view = userCardCollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //fetchUserFlashCards()
        userCardCollectionView.collectionView.dataSource = self
        userCardCollectionView.collectionView.delegate = self
        userCardCollectionView.collectionView.register(UserFlashCardCollectionViewCell.self, forCellWithReuseIdentifier: "userFlashCardCell")
        
    }
    
    private func fetchUserFlashCards() {
        do {
            userFlashCards = try dataPersistence.loadItems()
        } catch {
            print("error fetching articles: \(error)")
        }
    }
}


extension UserCardCollectionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return userFlashCards.count
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userFlashCardCell", for: indexPath) as? UserFlashCardCollectionViewCell else {
        fatalError("could not downcast to a UserCardCollectionViewCell")
      }
      let userFlashCard = userFlashCards[indexPath.row]
      cell.backgroundColor = .systemBackground
      cell.configreCell(for: userFlashCard)
        cell.delegate = self
      return cell
    }
}

extension UserCardCollectionController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let maxSize: CGSize = UIScreen.main.bounds.size
    let spacingBetweenItems: CGFloat = 10
    let numberOfItems: CGFloat = 2
    let itemHeight: CGFloat = maxSize.height * 0.30
    let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
    let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
    return CGSize(width: itemWidth, height: itemHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
}

extension UserCardCollectionController: DataPersistenceDelegate {
  func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
    fetchUserFlashCards()
  }
  
  func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
    fetchUserFlashCards()
  }
}

extension UserCardCollectionController: UserCardCollectionViewCellDelegate {
  func didSelectMoreButton(_ userCardCollectionViewCell: UserFlashCardCollectionViewCell, flashCard: FlashCard) {
    print("didSelectMoreButton: \(flashCard.quizTitle)")
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { alertAction in
      self.deleteFlashCard(flashCard)
    }
    alertController.addAction(cancelAction)
    alertController.addAction(deleteAction)
    present(alertController, animated: true)
  }
  
  private func deleteFlashCard(_ flashCard: FlashCard) {
    guard let index = userFlashCards.firstIndex(of: flashCard) else {
      return
    }
    do {
      try dataPersistence.deleteItem(at: index)
    } catch {
      print("error deleting flash card: \(error)")
    }
  }
}
