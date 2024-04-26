//
//  MySectionsCollectionViewController.swift
//  CollectionViewController
//
//  Created by Palliboina on 25/04/24.
//

import UIKit

//private let reuseIdentifier = "Cell"

//apply this class to scene in storyboard
class MySectionsCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customLayout = createLayout()
        collectionView.collectionViewLayout = customLayout
        
        prepareDataSource()
        prepareSnapshot()
        
    }
    
    func prepareDataSource(){
        let cellRegistration = UICollectionView.CellRegistration<FoodCell,ItemSecsData.ID>{cell,indexPath,itemID in
            if let item = appSecsData.items.first(where: {$0.id == itemID}) {
                cell.picture.image = UIImage(named: item.image)
            }
            
            //backgroundColor WHEN CELL SELECTED
            cell.configurationUpdateHandler = { cell,state in
                var backgroundConfig = UIBackgroundConfiguration.listPlainCell().updated(for: state)
                backgroundConfig.cornerRadius = 15
                if state.isSelected {
                    backgroundConfig.backgroundColor = .systemGray5
                }else{
                    backgroundConfig.backgroundColor = .systemBackground
                }
                cell.backgroundConfiguration = backgroundConfig
            }
        }
        
        appSecsData.dataSource = UICollectionViewDiffableDataSource<MySections,ItemSecsData.ID>(collectionView: collectionView){ (collection,indexPath,itemID) in
            return collection.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemID)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<MyHeader>(elementKind: UICollectionView.elementKindSectionHeader, handler: { headerView,kind,indexPath in
            if let sectionId = appSecsData.dataSource.sectionIdentifier(for: indexPath.section){
                headerView.picture.image = UIImage(named: "gradientTop")
                headerView.textView.text = sectionId == .selected ? "Selected" : "Available"
            }
        })
        
        appSecsData.dataSource.supplementaryViewProvider  = { collectionView,kind,indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
    }
    
    func prepareSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<MySections,ItemSecsData.ID>()
        snapshot.appendSections([.selected,.available])
        appSecsData.dataSource.apply(snapshot,animatingDifferences: true)
        
        let selectedIds = appSecsData.items.compactMap({value in
            return value.selected ? value.id : nil
        })
        var selectedSnapshot = NSDiffableDataSourceSectionSnapshot<ItemSecsData.ID>()
        selectedSnapshot.append(selectedIds)
        appSecsData.dataSource.apply(selectedSnapshot, to: .selected, animatingDifferences: false)
        
        let availableIds = appSecsData.items.compactMap({value in
            return value.selected ? nil : value.id
        })
        var availableSnapshot = NSDiffableDataSourceSectionSnapshot<ItemSecsData.ID>()
        availableSnapshot.append(availableIds)
        appSecsData.dataSource.apply(availableSnapshot, to: .available, animatingDifferences: false)


    }
    
    func createLayout() ->  UICollectionViewCompositionalLayout{
        ///fractionals  depends on space it calculates
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let itemId = appSecsData.dataSource.itemIdentifier(for: indexPath){
            if let item = appSecsData.items.first(where: {$0.id == itemId}) {
                if item.selected {
                    var selectedCurrentSnapshot = appSecsData.dataSource.snapshot(for: .selected)
                    selectedCurrentSnapshot.delete([itemId])
                    appSecsData.dataSource.apply(selectedCurrentSnapshot, to: .selected, animatingDifferences: true)
                    
                    item.selected = false
                    
                    let avialableIds = appSecsData.items.compactMap({value in
                        return value.selected ? nil : value.id
                    })
                    
                    var availableSnapshot = NSDiffableDataSourceSectionSnapshot<ItemSecsData.ID>()
                    availableSnapshot.append(avialableIds)
                    appSecsData.dataSource.apply(availableSnapshot, to: .available, animatingDifferences: false)
                    
                }else{
                    var availableCurrentSnapshot = appSecsData.dataSource.snapshot(for: .available)
                    availableCurrentSnapshot.delete([itemId])
                    appSecsData.dataSource.apply(availableCurrentSnapshot, to: .available, animatingDifferences: true)
                    
                    item.selected = true
                    
                    let selectedIds = appSecsData.items.compactMap({value in
                        return value.selected ? value.id : nil
                    })
                    
                    var selectedSnapshot = NSDiffableDataSourceSectionSnapshot<ItemSecsData.ID>()
                    selectedSnapshot.append(selectedIds)
                    appSecsData.dataSource.apply(selectedSnapshot, to: .selected, animatingDifferences: false)
                }
            }
        }
    }

    
}
