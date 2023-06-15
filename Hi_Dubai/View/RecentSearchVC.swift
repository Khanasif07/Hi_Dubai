//
//  RecentSearchVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 16/06/2023.
//

import UIKit

class RecentSearchVC: UIViewController {
    
    private var placesView: PlacesAndSuperShesView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.placesView = PlacesAndSuperShesView(frame: CGRect(x: 0.0, y: 0.0, width: screen_width, height: screen_height))
        
        if let placeView = self.placesView {
            placeView.screenUsingFor = .places
            self.view.addSubview(placeView)
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        placesView?.dataTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.placesView?.frame = CGRect(x: 0.0, y: 0.0, width: screen_width, height: screen_height)
    }

}
