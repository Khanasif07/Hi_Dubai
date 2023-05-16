//
//  BaseNestedTabViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 11/05/2023.
//
import UIKit
import Foundation
class BaseNestedTabViewController : BaseViewController {

    var shouldActAsNestedScrollview:Bool = true

    func scrollViewDidScroll(scrollView:UIScrollView!) {
        let offsetY:CGFloat = scrollView.contentOffset.y
    //        NSLog(@"Nested Scroll offset y = %.2f",offsetY);
        if offsetY <= 0.0 && scrollView.isScrollEnabled && self.shouldActAsNestedScrollview {
            scrollView.isScrollEnabled = false
        }
        self.childScrollViewDidScroll(scrollView: scrollView)
    }

    func childScrollViewDidScroll(scrollView:UIScrollView!) {

    }
}
