//
//  MyListCollectionViewController.swift
//  CollectionViewController
//
//  Created by Palliboina on 26/04/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class MyListCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        config.headerMode = .supplementary
        config.separatorConfiguration.color = .systemRed
        config.itemSeparatorHandler = {indexPath,config in
            let row = indexPath.row
            let section = indexPath.section
            var lastRow = 0
            if let sectionId = appData.dataSource.sectionIdentifier(for: section) {
                lastRow = appData.dataSource.snapshot().numberOfItems(inSection: sectionId)
                lastRow = lastRow > 0 ? lastRow - 1 : 0
            }
            var configuration = config
            configuration.topSeparatorVisibility = row == 0 ? .hidden : .automatic
            configuration.bottomSeparatorVisibility = row == lastRow ? .hidden : .automatic
            return configuration
        }
        
        config.trailingSwipeActionsConfigurationProvider = {indexPath in
            let button = UIContextualAction(style: .normal, title: "Delete Food", handler: {action,view,completion in
                if let itemId = appData.dataSource.itemIdentifier(for: indexPath),let sectionId = appData.dataSource.sectionIdentifier(for: indexPath.section) {
                    appData.items.removeAll(where: {$0.id == itemId})
                    
                    var currentSnapshot = appData.dataSource.snapshot()
                    currentSnapshot.deleteItems([itemId])
                    if currentSnapshot.numberOfItems(inSection: sectionId) <= 0 {
                        appData.sections.removeAll(where: {$0.id == sectionId})
                        currentSnapshot.deleteSections([sectionId])
                    }
                    appData.dataSource.apply(currentSnapshot)
                }
                completion(true)
            })
            
            button.backgroundColor = .systemBrown
            
            let config = UISwipeActionsConfiguration(actions: [button])
            return config
        }
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        collectionView.collectionViewLayout = layout
        
        collectionView.isEditing =  true
        
        prepareDataSource()
        prepareSnapshot()
        
    }
    
    func prepareDataSource(){
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell,ItemData.ID>{ cell, indexPath, itemId in
            if let item = appData.items.first(where: {$0.id == itemId}) {
                var config = cell.defaultContentConfiguration()
                config.text = item.name
                config.secondaryText = "Calories : \(item.calories)"
                config.image = UIImage(named:item.image)
                config.imageProperties.maximumSize = CGSize(width: 60, height: 60)
                cell.contentConfiguration = config
                
                cell.accessories = item.selected ? [.checkmark(),.delete()] : []
            }
        }
        
        appData.dataSource = UICollectionViewDiffableDataSource<Sections.ID,ItemData.ID>(collectionView: collectionView, cellProvider: { collection,indexPath,itemId in
            
            return collection.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemId)
        })
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<MyHeader>(elementKind: UICollectionView.elementKindSectionHeader, handler: {view,kind,indexPath in
            view.textView.text = appData.sections[indexPath.section].name
            //view.picture.image = UIImage(named: "gradientTop")
        })
        
        appData.dataSource.supplementaryViewProvider = { collectionView,kind,indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
    }
    
    func prepareSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Sections.ID,ItemData.ID>()
        snapshot.appendSections(appData.sections.map({$0.id}))
        for section in appData.sections {
            let itemIds = appData.items.compactMap({value in
                return value.section == section.name ? value.id : nil
            })
            snapshot.appendItems(itemIds, toSection: section.id)
        }
        
        appData.dataSource.apply(snapshot)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let itemid = appData.dataSource.itemIdentifier(for: indexPath) {
            if let item = appData.items.first(where: {$0.id == itemid}) {
                item.selected.toggle()
                
                var current = appData.dataSource.snapshot()
                current.reconfigureItems([itemid])
                appData.dataSource.apply(current)
                
                collectionView.deselectItem(at: indexPath, animated: true)
            }
        }
    }

}
