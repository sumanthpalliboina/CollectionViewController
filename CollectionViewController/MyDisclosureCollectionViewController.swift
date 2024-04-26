//
//  MyDisclosureCollectionViewController.swift
//  CollectionViewController
//
//  Created by Palliboina on 26/04/24.
//

import UIKit

//private let reuseIdentifier = "Cell"

class MyDisclosureCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        collectionView.collectionViewLayout = layout
        
        prepareDataSource()
        prepareSnapshot()
    }
    
    func prepareDataSource(){
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell,DisclosureItemsData.ID>{ cell, indexPath, itemId in
            if let item = self.getItem(id: itemId) {
                var config = cell.defaultContentConfiguration()
                config.text = item.name
                
                if item.options == nil {
                    config.secondaryText = "Calories : 340"
                    config.image = UIImage(named:item.name.lowercased())
                    config.imageProperties.maximumSize = CGSize(width: 60, height: 60)
                }
                
                cell.contentConfiguration = config
                
                cell.accessories = item.options != nil ? [.outlineDisclosure()] : []
            }
        }
        
        appDisclosureData.datasource = UICollectionViewDiffableDataSource<DisclosureSections,DisclosureItemsData.ID>(collectionView: collectionView, cellProvider: { collection,indexPath,itemId in
            
            return collection.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemId)
        })
    }
    
    func prepareSnapshot(){
        var snapshot = NSDiffableDataSourceSectionSnapshot<DisclosureItemsData.ID>()
        
        for parent in appDisclosureData.items{
            snapshot.append([parent.id], to: nil)
            snapshot.append(parent.options.map({$0.id}), to: parent.id)
        }
        
        appDisclosureData.datasource.apply(snapshot, to: .main, animatingDifferences: false)
        
    }

    
    func getItem(id:DisclosureItemsData.ID) -> DisclosureItemsData?{
        var item = appDisclosureData.items.first(where: {$0.id == id})
        if item == nil {
            for discloseItem in appDisclosureData.items {
                if let found = discloseItem.options.first(where: {$0.id == id}) {
                    item = found
                    break
                }
            }
        }
        return item
    }

}
