//
//  PageViewControllers.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 02/06/2023.
//

import Foundation
import UIKit
import SwiftUI
class PageViewControllers: BaseVC{
    
    //MARK: - IBOutlets..
    @IBOutlet weak var mainCollView: UICollectionView!
    
    //MARK: - Properties..
    @State var animals: [Animal] = Bundle.main.decode("animals.json")
    
    //MARK: - View Life Cycle..
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarClear = false
        self.setNavigationBarHidden = false
        self.collViewSetup()
    }
    
    //MARK: - Function..
    //MARK: - Two column only collectionViewFlowLayout
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //MARK: - Height logic is here...(.fixed and .estimated)
        let width = self.view.frame.width - 50.0
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(width/3))
        //
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func collViewSetup(){
        mainCollView.registerCell(with: PhotoCollCell.self)
        mainCollView.delegate = self
        mainCollView.dataSource = self
        mainCollView.collectionViewLayout = createLayout()
    }
}

//MARK: - Extension..
extension PageViewControllers: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollView.dequeueCell(with: PhotoCollCell.self, indexPath: indexPath)
        //
        cell.embed(in: self,withContent: animals[indexPath.item])
        //
        return cell
    }
    //MARK: - createLayout is using..
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = self.mainCollView.frame.width - 30.0
//        return CGSize(width: width / 3.0 , height: width / 3.0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        let paddingInset: CGFloat = 5.0
//        return UIEdgeInsets(top: 0, left: paddingInset, bottom: 0, right: paddingInset)
//    }

}
