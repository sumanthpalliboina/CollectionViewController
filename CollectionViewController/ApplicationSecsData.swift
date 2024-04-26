//
//  ApplicationSecsData.swift
//  CollectionViewController
//
//  Created by Palliboina on 25/04/24.
//

import Foundation
import UIKit

enum MySections{
    case selected, available
}

class ItemSecsData : Identifiable {
    var id:UUID = UUID()
    var name:String
    var image:String
    var calories:Int
    var selected:Bool
    
    init(name: String, image: String, calories: Int, selected: Bool) {
        self.name = name
        self.image = image
        self.calories = calories
        self.selected = selected
    }
    
}

struct ApplicationSecsData {
    
    var dataSource:UICollectionViewDiffableDataSource<MySections,ItemData.ID>!
    var items:[ItemSecsData] = [] {
        didSet{
            items.sort(by: {$0.name < $1.name})
        }
    }

    
    init(){
        
        items.append(ItemSecsData(name: "Bagels", image: "bagels", calories: 250, selected: false))
        items.append(ItemSecsData(name: "Brownies", image: "brownies", calories: 466, selected: false))
        items.append(ItemSecsData(name: "Butter", image: "butter", calories: 717, selected: false))
        items.append(ItemSecsData(name: "Cheese", image: "cheese", calories: 402, selected: false))
        items.append(ItemSecsData(name: "Coffee", image: "coffee", calories: 0, selected: false))
        items.append(ItemSecsData(name: "Tomatoes", image: "tomatoes", calories: 502, selected: false))
        items.append(ItemSecsData(name: "Potatoes", image: "potatoes", calories: 250, selected: false))
        items.append(ItemSecsData(name: "Grapes", image: "grapes", calories: 250, selected: false))
        items.append(ItemSecsData(name: "Brinjal", image: "brinjal", calories: 250, selected: false))
    }
}

var appSecsData = ApplicationSecsData()
