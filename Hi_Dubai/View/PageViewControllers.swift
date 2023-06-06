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
        self.navTitle = "Learn about Animals"
        super.viewDidLoad()
        self.setNavigationBarClear = false
        self.setNavigationBarHidden = false
        self.collViewSetup()
    }
    //MARK: - How to use SwiftUI as UIView in Storyboard
    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: GalleryView(animal: animals[0]))
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        //MARK: - Add Header..
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(67))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        //
        //MARK: - Add Footer..
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(67))
        let footerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        //
        section.boundarySupplementaryItems = [headerElement,footerElement]
       
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func collViewSetup(){
        mainCollView.contentInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
        mainCollView.registerCell(with: PhotoCollCell.self)
        mainCollView.register(UINib(nibName: "HeaderViewCV", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderViewCV")
        mainCollView.register(UINib(nibName: "FooterViewCV", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterViewCV")
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIHostingController(rootView: AnimalDetailView(animal: animals[indexPath.item]))
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       switch kind {
       case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderViewCV", for: indexPath)
                return headerView
        case UICollectionView.elementKindSectionFooter:
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterViewCV", for: indexPath)
                return footerView
         default:
                assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.mainCollView.frame.width, height: 67)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.mainCollView.frame.width, height: 67)
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


