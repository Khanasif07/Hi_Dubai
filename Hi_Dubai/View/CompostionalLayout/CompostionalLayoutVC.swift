//
//  CompostionalLayoutVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 07/06/2023.
//

import UIKit

class CompostionalLayoutVC: BaseVC {
    /* uicollectionviewcompositionallayout
     Section->
              Groups->
                       Items
     */
    
    //MARK: - IBOutlets
    @IBOutlet weak var cardCollView: UICollectionView!
    
    
    //MARK: - Properties
    var animals: [Animal] = Bundle.main.decode("animals.json")
    let compositionalLayout: UICollectionViewCompositionalLayout = {
        let fraction: CGFloat = 1 / 3
        let inset: CGFloat = 2.5

        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        //Supplementary Item
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.1), heightDimension: .absolute(30))
        let containerAnchor = NSCollectionLayoutAnchor(edges: [.bottom], absoluteOffset: CGPoint(x: 0, y: 10))
        let supplementaryItem = NSCollectionLayoutSupplementaryItem(layoutSize: layoutSize, elementKind: "new-banner", containerAnchor: containerAnchor)
        //
        let item = NSCollectionLayoutItem(layoutSize: itemSize,supplementaryItems: [supplementaryItem])
        // after item declaration…
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        // after section delcaration…
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        // section header delcaration…
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44.0))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [headerItem]
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Compositional Layout"
        setNavigationBarHidden = false
        setNavigationBarClear = false
        // Do any additional setup after loading the view.
    }
    
    internal override func initialSetup() {
        collViewSetUp()
    }
    
    private func collViewSetUp(){
        cardCollView.register(UINib(nibName: "HeaderViewCV", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderViewCV")
        cardCollView.register(UINib(nibName: "FooterViewCV", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterViewCV")
        cardCollView.register(UINib(nibName: "NewBannerSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "new-banner", withReuseIdentifier: "NewBannerSupplementaryView")
        cardCollView.registerCell(with: PhotoCollCell.self)
        cardCollView.delegate = self
        cardCollView.dataSource = self
        cardCollView.collectionViewLayout = compositionalLayout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    //MARK: - IBActions
    
    
    //MARK: - Functions
    
}

//MARK: - Extension
extension CompostionalLayoutVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardCollView.dequeueCell(with: PhotoCollCell.self, indexPath: indexPath)
        //
        cell.dataView.isHidden = false
        cell.dataView.backgroundColor = UIColor(hue: CGFloat(indexPath.item) / 20.0, saturation: 0.8, brightness: 0.9, alpha: 1)
        //
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       switch kind {
       case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderViewCV", for: indexPath)
                return headerView
       case "new-banner":
           let bannerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NewBannerSupplementaryView", for: indexPath)
           bannerView.isHidden = indexPath.row % 5 != 0 // show on every 5th item
           return bannerView
        case UICollectionView.elementKindSectionFooter:
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterViewCV", for: indexPath)
                return footerView
         default:
                assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.cardCollView.frame.width, height: 44)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.cardCollView.frame.width, height: 44)
    }
    
}
