//
//  StatsVC.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 01/05/2023.
//

import UIKit

class StatsVC: UIViewController {
    
    //MARK:- IBOUTLETS
    //==================
    @IBOutlet weak var mainTableView: UITableView!
    
     var artistSymbol: String = "ARIG"
    lazy var viewModel = {
        NewsListViewModel()
    }()
    
    //MARK:- VIEW LIFE CYCLE
    //==================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetUp()
    }
    
    
    //MARK:- PRIVATE FUNCTIONS
    //==================
    
    private func initialSetUp() {
        self.tableViewSetUp()
//        self.footerViewSetUp()
        self.registerXib()
        self.fetchAPIData()
    }
    
    private func fetchAPIData(){
        self.viewModel.delegate = self
        self.viewModel.getNewsListing()
    }
    
    private func tableViewSetUp() {
        self.mainTableView.delegate    = self
        self.mainTableView.dataSource  = self
        self.mainTableView.rowHeight = UITableView.automaticDimension
        self.mainTableView.estimatedRowHeight = 300
    }
    
    private func footerViewSetUp() {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 181.0))
        self.mainTableView.tableFooterView?.height = 181.0
        self.mainTableView.tableFooterView = footerView
    }
    
    private func registerXib(){
        self.mainTableView.registerCell(with: NewsTableViewCell.self)
    }
    
    
}
//MARK:- TABLEVIEW DELEGATE AND DATA SOURCE
//==================

extension StatsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsData.isEmpty ? self.setEmptyMessage(self.viewModel.error?.localizedDescription ?? "") : self.restore()
        return self.viewModel.newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableViewCellForStats(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewHeightForStats(tableView, heightForRowAt: indexPath)
    }
    
    //Internal functions
    internal  func tableViewCellForStats(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: NewsTableViewCell.self)
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
    internal func tableViewHeightForStats(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first!
        let location = touch.location(in: self.view)
       // self.yPos = location.y
    }
    
}

//MARK:- Extension NewsListViewModelDelegate
extension StatsVC: NewsListViewModelDelegate{
    func newsListingSuccess() {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
    
    func newsListingFailure(error: Error) {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
}

extension StatsVC{
    func setEmptyMessage(_ message: String,isTimeOutError: Bool = true) {
        let emptyView = UIView(frame: CGRect(x: self.mainTableView.centerX, y: self.mainTableView.centerY, width: self.mainTableView.size.width, height: self.mainTableView.size.height - 50))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        let retryButton = UIButton()
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        retryButton.setTitle("Retry", for: .normal)
        retryButton.addTarget(self, action: #selector(retryBtnTapped), for: .touchDown)
        retryButton.setTitleColor(.red, for: .normal)
        retryButton.setTitleColor(.red, for: .selected)
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        emptyView.addSubview(retryButton)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 10).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -10).isActive = true
        
        retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10).isActive = true
        retryButton.leftAnchor.constraint(equalTo: messageLabel.leftAnchor, constant: 10).isActive = true
        retryButton.rightAnchor.constraint(equalTo: messageLabel.rightAnchor, constant: -10).isActive = true
        titleLabel.text = "You don't have any contact."
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        emptyView.backgroundColor = .yellow
        emptyView.roundCorners([.allCorners], radius: 10.0)
        // The only tricky part is here:
        mainTableView.backgroundView = emptyView
        mainTableView.separatorStyle = .none
        
        
    }
    
    @objc func retryBtnTapped(){
        print("retry btn tapped.")
        self.fetchAPIData()
    }
    
    func restore() {
        mainTableView.backgroundView = nil
        mainTableView.separatorStyle = .singleLine
    }
}
