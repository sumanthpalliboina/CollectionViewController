//
//  ApplicationData.swift
//  TableView
//
//  Created by Palliboina on 20/04/24.
//

import Foundation
import UIKit

/*enum Sections{
    case main
}*/

class Sections :Identifiable {
    var id:UUID = UUID()
    var name:String
    
    init(name: String) {
        self.name = name
    }
}

class ItemData : Identifiable {
    var id:UUID = UUID()
    var name:String
    var image:String
    var calories:Int
    var selected:Bool
    var section:String
    
    init(name: String, image: String, calories: Int, selected: Bool, section:String) {
        self.name = name
        self.image = image
        self.calories = calories
        self.selected = selected
        self.section = section
    }
    
}

struct ApplicationData {
    
    var dataSource:UICollectionViewDiffableDataSource<Sections.ID,ItemData.ID>!
    var sections:[Sections] = [] {
        didSet{
            sections.sort(by: {$0.name < $1.name})
        }
    }
    var items:[ItemData] = [] {
        didSet{
            items.sort(by: {$0.name < $1.name})
        }
    }

    
    init(){
        sections.append(contentsOf: [Sections(name: "B"),Sections(name: "C"),Sections(name: "T"),Sections(name: "P"),Sections(name: "G")])
        
        items.append(ItemData(name: "Bagels", image: "bagels", calories: 250, selected: false, section:"B"))
        items.append(ItemData(name: "Brownies", image: "brownies", calories: 466, selected: false, section:"B"))
        items.append(ItemData(name: "Butter", image: "butter", calories: 717, selected: false, section:"B"))
        items.append(ItemData(name: "Cheese", image: "cheese", calories: 402, selected: false, section:"C"))
        items.append(ItemData(name: "Coffee", image: "coffee", calories: 0, selected: false, section:"C"))
        items.append(ItemData(name: "Tomatoes", image: "tomatoes", calories: 502, selected: false, section:"T"))
        items.append(ItemData(name: "Potatoes", image: "potatoes", calories: 250, selected: false, section:"P"))
        items.append(ItemData(name: "Grapes", image: "grapes", calories: 250, selected: false, section:"G"))
        items.append(ItemData(name: "Brinjal", image: "brinjal", calories: 250, selected: false, section:"B"))
    }
}

var appData = ApplicationData()
