//
//  SuperYouPastLivTableCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 18/07/2023.
//

import UIKit
class SuperYouPastLivTableCell: UITableViewCell {
    
    //MARK:- Variables
    let layoutt = UICollectionViewFlowLayout()
    // Velocity is measured in points per millisecond.
    var superYouData: SuperYouHomeModel?
    
    //MARK:- IBOutlets
    @IBOutlet weak var emptyView: EmptyView!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    //MARK:- LifeCycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.emptyView.isHidden = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    //MARK:- Functions
    
    /// Call to configure ui
    private func configureUI() {
        self.cardCollectionView.registerCell(with: PartnerCollectionCell.self)
        self.cardCollectionView.delegate = self
        self.cardCollectionView.dataSource = self
        self.emptyView.isHidden = true
        configureCell()
    }
    
    
    ///Call to populates data
    func configureCell() {
        self.cardCollectionView.isPagingEnabled = false
        self.cardCollectionView.collectionViewLayout = createCompositionalLayout()
        self.cardCollectionView.reloadData()
    }
    

    ///Get Music Cell
    private func getPastLiveCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: PartnerCollectionCell.self, indexPath: indexPath)
        cell.populateCell(model: superYouData?.pastLiveData[indexPath.row])
        return cell
    }
}

//MARK:- UICollectionView Extensions
extension SuperYouPastLivTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.superYouData?.pastLiveData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return self.getPastLiveCell(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {

        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { [weak self] _ in
                let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
//                    self?.downloadTitleAt(indexPath: indexPath)
                }
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
            }

        return config
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ClassInitalLayoutConstants.collLiveCellWidth, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 9.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var paddingInset: CGFloat = 0.0
        return UIEdgeInsets(top: 0, left: paddingInset, bottom: 0, right: paddingInset)
    }
}

extension SuperYouPastLivTableCell{
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            case 0:
                return self.createPastLiveVids(using: sectionIndex)
            default:
                return self.createPastLiveVids(using: sectionIndex)
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 0
//        config.scrollDirection = .horizontal
        layout.configuration = config
        return layout
    }
    
    func createPastLiveVids(using section: Int) -> NSCollectionLayoutSection {
        //TODO: - to show 3 rows...
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        //TODO: - to show 1 rows...
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalHeight(1))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered

//        let layoutSectionHeader = createSectionHeader()
//        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

        return layoutSection
    }

}

