//
//  FlashCardCollectionControllerView.swift
//  Unit4Assessment
//
//  Created by Lilia Yudina on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class FlashCardCollectionControllerView: UIView {
    
    public lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .vertical
       let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
       cv.backgroundColor = .systemGroupedBackground
       return cv
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
       setupCollectionViewConstraints()
     }
     
     
     private func setupCollectionViewConstraints() {
       addSubview(collectionView)
       collectionView.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
         collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
         collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
         collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
       ])
     }
}
