//
//  FoodCell.swift
//  CollectionViewController
//
//  Created by Palliboina on 24/04/24.
//

import Foundation
import UIKit

class FoodCell : UICollectionViewCell {
    let picture = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.contentMode = .scaleAspectFit
        self.contentView.addSubview(picture)
        
        picture.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        picture.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        picture.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        picture.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
