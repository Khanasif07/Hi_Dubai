//
//  BaseNestedScrollViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 09/05/2023.
//

import Foundation
import UIKit
var NAVBAR_CHANGE_POINT = 64.0
class BaseNestedScrollViewController : BaseViewController, UIScrollViewDelegate {
    private var lastContentOffset: CGFloat = 0

    private var _childScrollView: UIScrollView = UIScrollView()
    var childScrollView: UIScrollView! {
        get { return _childScrollView }
        set(childScrollView) {
             childScrollView.isScrollEnabled = _childScrollView.isScrollEnabled
            _childScrollView = childScrollView
            _childScrollView.bounces = false
            _childScrollView.alwaysBounceVertical = false
            _childScrollView.delegate = self
        }
    }
    private var scrollView:UIScrollView! = UIScrollView()
    private var tabContainer:UIView = UIView()
    private var tabContainerHeightConstraint:NSLayoutConstraint!
    private var fakeNavBar:UIImageView =  UIImageView()
    internal var titleLabel:UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    func setUIObjectsScrollView(scrollView: UIScrollView!, tabContainer:UIView!, heightConstraint tabContainerHeightConstraint:NSLayoutConstraint!, fakeNavBar:UIImageView!, titleLabel:UILabel!) {
        self.scrollView = scrollView
        self.scrollView.delegate = self
        self.tabContainer = tabContainer
        self.tabContainerHeightConstraint = tabContainerHeightConstraint
        self.fakeNavBar = fakeNavBar
        self.titleLabel = titleLabel
        let swipeGesture:UISwipeGestureRecognizer! = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .up
        swipeGesture.delegate = self
        self.scrollView.addGestureRecognizer(swipeGesture)
        self.scrollView.isUserInteractionEnabled = true
        let swipeGestureD:UISwipeGestureRecognizer! = UISwipeGestureRecognizer(target:self, action:#selector(handleSwipeGesture(_:)))
        swipeGestureD.direction = .down
        swipeGestureD.delegate = self
        self.scrollView.addGestureRecognizer(swipeGestureD)
    }

    func scrollViewDidScroll(_ scrollView:UIScrollView) {
        let offsetY:CGFloat = scrollView.contentOffset.y
        //    NSLog(@"Scroll offset y = %.2f",offsetY);
        if scrollView.isEqual(self.scrollView) {
            if offsetY > NAVBAR_CHANGE_POINT {
                let alpha:CGFloat = min(1, 1 - ((NAVBAR_CHANGE_POINT + 79 - offsetY) / 79))
                self.fakeNavBar.alpha = alpha
                self.titleLabel.alpha = alpha
            } else {
                self.fakeNavBar.alpha = 0
                self.titleLabel.alpha = 0
            }
            
        }
        let scrollViewBottomEdge:CGFloat = scrollView.contentOffset.y + CGRectGetHeight(scrollView.frame)
        print("scrollView.contentOffset.y:- \(scrollView.contentOffset.y)")
        print("CGRectGetHeight(scrollView.frame:- \(CGRectGetHeight(scrollView.frame))")
        print("self.scrollView.contentSize.height:- \(self.scrollView.contentSize.height)")
        if floorf(Float(scrollViewBottomEdge)*100)/100 >= floorf(Float(self.scrollView.contentSize.height)*100)/100 {
            self.childScrollView.isScrollEnabled = true
        }
    }


    @objc func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        let scrollViewBottomEdge:CGFloat = self.scrollView.contentOffset.y + CGRectGetHeight(self.scrollView.frame)
        //Gesture detect - swipe up/down , can be recognized direction
        if sender.direction == .up
        {
            print("Direction UP")
            if scrollViewBottomEdge >= self.scrollView.contentSize.height && _childScrollView.contentOffset.y == 0.00 && _childScrollView.frame.size.height < _childScrollView.contentSize.height {
                _childScrollView.isScrollEnabled = true
                _childScrollView.setContentOffset(CGPointMake(0, min(_childScrollView.contentSize.height - _childScrollView.frame.size.height , 200)), animated:true)
            }
        }
        else if sender.direction == .down
        {
            print("Direction DOWN")
            if scrollViewBottomEdge >= self.scrollView.contentSize.height && _childScrollView.contentOffset.y == 0.00 && _childScrollView.isScrollEnabled {
                _childScrollView.isScrollEnabled = false
                self.scrollView.setContentOffset(CGPointMake(0, max(self.scrollView.contentOffset.y-400,100)),animated:true)
            }
        }}

    // `setChildScrollView:` has moved as a setter.

    func getChildScrollViewRef() -> UIScrollView! {
        return  _childScrollView
    }

    func enableScrollOnChildScrollView(childScrollView:UIScrollView!) {
        childScrollView.isScrollEnabled = true
        _childScrollView.bounces = true
        _childScrollView.alwaysBounceVertical = true
    }

    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(true)
        self.scrollViewDidScroll(self.scrollView)

        var offset:CGFloat = 0


        var fakenavHeightRef:CGFloat = 44.0

        if #available(iOS 13.0, *) {
            let window:UIWindow! = UIApplication.shared.currentWindow
            fakenavHeightRef =  fakenavHeightRef + window.safeAreaInsets.top

        }else if #available(iOS 11.0, *) {
            let window:UIWindow! = UIApplication.shared.keyWindow
            fakenavHeightRef = fakenavHeightRef + window.safeAreaInsets.top
        }

        if #available(iOS 11.0, *) {
            let window:UIWindow! = UIApplication.shared.currentWindow
            offset = window.safeAreaInsets.bottom

        }

        if offset < 0 {
            offset = 0
        }

       // fakenavHeightRef = 79;

       /* if (@available(iOS 11.0, *)) {
            if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
                if ((int)[[UIScreen mainScreen] nativeBounds].size.height == 2436) {
                    offset = 30;
                }
            }
        }*/
        self.tabContainerHeightConstraint.constant = UIScreen.main.bounds.size.height-fakenavHeightRef-49-offset
        self.view.layoutIfNeeded()
    }

    override func viewWillDisappear(_ animated:Bool) {
        super.viewWillDisappear(animated)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
      }

      func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
      }

}
