//
//  ApplicationDisclosureData.swift
//  CollectionViewController
//
//  Created by Palliboina on 26/04/24.
//

import Foundation
import UIKit

enum DisclosureSections{
    case main
}

struct DisclosureItemsData:Identifiable {
    var id:UUID = UUID()
    var name:String!
    var options:[DisclosureItemsData]!
}

struct ApplicationDisclosureData{
    var datasource:UICollectionViewDiffableDataSource<DisclosureSections,DisclosureItemsData.ID>!
    
    var items = [
        DisclosureItemsData(name: "Food",options: [
            DisclosureItemsData(name: "Bagels",options: nil),
            DisclosureItemsData(name: "Brownies",options: nil),
            DisclosureItemsData(name: "Cheese",options: nil),
            DisclosureItemsData(name: "Noodles",options: nil),
            DisclosureItemsData(name: "Donuts",options: nil)
        ]),
        DisclosureItemsData(name: "Vegetables",options: [
            DisclosureItemsData(name: "Brinjal",options: nil),
            DisclosureItemsData(name: "Potatoes",options: nil)
        ]),
        DisclosureItemsData(name: "Fruits",options: [
            DisclosureItemsData(name: "Grapes",options: nil)
        ]),
        DisclosureItemsData(name: "Beverages",options: [
            DisclosureItemsData(name: "Coffee",options: nil),
            DisclosureItemsData(name: "Lemonade",options: nil)
        ])
    ]
}

var appDisclosureData = ApplicationDisclosureData()
