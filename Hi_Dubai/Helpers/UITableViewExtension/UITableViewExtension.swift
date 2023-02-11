//
//  UITableViewExtension.swift
//  Hi_Dubai
//
//  Created by Admin on 11/02/23.
//

import Foundation
import UIKit
extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.boldSystemFont(ofSize: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    ///Returns cell for the given item
    func cell(forItem item: Any) -> UITableViewCell? {
        if let indexPath = self.indexPath(forItem: item){
            return self.cellForRow(at: indexPath)
        }
        return nil
    }
    
    ///Returns the indexpath for the given item
    func indexPath(forItem item: Any) -> IndexPath? {
        let itemPosition: CGPoint = (item as AnyObject).convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: itemPosition)
    }
    
    ///Registers the given cell
    func registerClass(cellType:UITableViewCell.Type){
        register(cellType, forCellReuseIdentifier: cellType.defaultReuseIdentifier)
    }
    
    ///dequeues a reusable cell for the given indexpath
    func dequeueReusableCellForIndexPath<T: UITableViewCell>(indexPath: NSIndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier , for: indexPath as IndexPath) as? T else {
            fatalError( "Failed to dequeue a cell with identifier \(T.defaultReuseIdentifier). Ensure you have registered the cell." )
        }
        
        return cell
    }
    
    func indexPathForCells(inSection: Int, exceptRows: [Int] = []) -> [IndexPath] {
        let rows = self.numberOfRows(inSection: inSection)
        var indices: [IndexPath] = []
        for row in 0..<rows {
            if exceptRows.contains(row) { continue }
            indices.append([inSection, row])
        }
        
        return indices
    }
    ///Register Table View Cell Nib
    func registerCell(with identifier: UITableViewCell.Type)  {
        self.register(UINib(nibName: "\(identifier.self)",bundle:nil),
                      forCellReuseIdentifier: "\(identifier.self)")
    }
    
    ///Register Header Footer View Nib
    func registerHeaderFooter(with identifier: UITableViewHeaderFooterView.Type)  {
        self.register(UINib(nibName: "\(identifier.self)",bundle:nil), forHeaderFooterViewReuseIdentifier: "\(identifier.self)")
    }
    
    ///Dequeue Table View Cell
    func dequeueCell <T: UITableViewCell> (with identifier: T.Type, indexPath: IndexPath? = nil) -> T {
        if let index = indexPath {
            return self.dequeueReusableCell(withIdentifier: "\(identifier.self)", for: index) as! T
        } else {
            return self.dequeueReusableCell(withIdentifier: "\(identifier.self)") as! T
        }
    }
    ///Dequeue Header Footer View
    func dequeueHeaderFooter <T: UITableViewHeaderFooterView> (with identifier: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: "\(identifier.self)") as! T
    }
    
    public func enablePullToRefresh(tintColor: UIColor, target: UIViewController, selector: Selector){
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(target, action: selector, for: UIControl.Event.valueChanged)
        refreshControl.tintColor = tintColor
        self.addSubview(refreshControl)
    }

}

extension UITableViewCell {
    public static var defaultReuseIdentifier: String {
        return "\(self)"
    }
}
