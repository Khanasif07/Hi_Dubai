//
//  RecentSearchVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 16/06/2023.
//

import UIKit

class RecentSearchVC: UIViewController {
    
    internal var placesView: PlacesAndSuperShesView?
    var screenUsingFor: CurrentlyUsingFor = .places{
        willSet(newValue){
            self.placesView?.screenUsingFor = newValue
        }
        didSet{
            self.placesView?.hitApi()
        }
    }
    var lastContentOffset: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.placesView = PlacesAndSuperShesView(frame: CGRect(x: 0.0, y: 0.0, width: screen_width, height: screen_height))
        self.placesView?.isScrollEnabled = true
        if let placeView = self.placesView {
            placeView.screenUsingFor = screenUsingFor
            self.view.addSubview(placeView)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.placesView?.frame = CGRect(x: 0.0, y: 0.0, width: screen_width, height: screen_height)
    }

}
