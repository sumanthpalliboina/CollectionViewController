//
//  MyCollectionViewController.swift
//  CollectionViewController
//
//  Created by Palliboina on 24/04/24.
//

import UIKit

//private let reuseIdentifier = "Cell"

//Assign this class to collection view controller scene in identify inspector panel
class MyCollectionViewController: UICollectionViewController/*,UICollectionViewDelegateFlowLayout*/ {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customLayout = createLayout()
        collectionView.collectionViewLayout = customLayout
        
    /*  let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        ///make sure estimate size option is none in size inspector panel
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20) //padding around them
        
        collectionView.delegate = self */
        
        prepareDataSource()
        prepareSnapshot()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    func prepareDataSource(){
        let cellRegistration = UICollectionView.CellRegistration<FoodCell,ItemData.ID>{cell,indexPath,itemID in
            if let item = appData.items.first(where: {$0.id == itemID}) {
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
        
        appData.dataSource = UICollectionViewDiffableDataSource<Sections.ID,ItemData.ID>(collectionView: collectionView){ (collection,indexPath,itemID) in
            return collection.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemID)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<MyHeader>(elementKind: UICollectionView.elementKindSectionHeader, handler: { headerView,kind,indexPath in
            headerView.picture.image = UIImage(named: "gradientTop")
            headerView.textView.text = appData.sections[indexPath.section].name
        })
        
        appData.dataSource.supplementaryViewProvider  = { collectionView,kind,indexPath in
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
    
    //every third item will display large size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width:CGFloat = 146
        var height:CGFloat = 100
        
        if indexPath.item % 3 == 0{
            width = 292
            height = 200
        }
        
        return CGSize(width: width, height: height)
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
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    /*override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }*/

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
