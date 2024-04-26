//
//  MyHeader.swift
//  CollectionViewController
//
//  Created by Palliboina on 25/04/24.
//

import Foundation
import UIKit

/*class MyHeader : UICollectionReusableView {
    var picture = UIImageView()
    var textView = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.contentMode = .scaleToFill
        picture.backgroundColor = .blue
        self.addSubview(picture)
        
        picture.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        picture.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        picture.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        picture.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .title1)
        self.addSubview(textView)
        
        textView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}*/

class MyHeader : UICollectionReusableView {
    var picture = UIImageView()
    var textView = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .headline)
        self.addSubview(textView)
        
        textView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor,constant: 16).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
