//
//  HeaderScrollView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 17/05/2023.
//

import Foundation
import UIKit

class HeaderScrollingView: UIView {
    
    fileprivate var previousPoint: CGFloat = 0
    
    private(set) weak var constraint: NSLayoutConstraint!
    
    // In default use, maxFollowPoint should be maxPoint of following to scroll DOWN.
    fileprivate var maxFollowPoint: CGFloat = 0
    // In default use, minFollowPoint should be maxPoint of following to scroll UP.
    fileprivate var minFollowPoint: CGFloat = 0
    
    // These properties are enable to delay showing and hiding ScrollingFollowView.
    private var pointOfStartingHiding: CGFloat = 0
    private var pointOfStartingShowing: CGFloat = 0
    
    fileprivate var delayBuffer: CGFloat = 0
    
    private(set) var allowHalfDisplay = false
    
    func setup(constraint cons: NSLayoutConstraint, maxFollowPoint: CGFloat, minFollowPoint: CGFloat, allowHalfDisplay: Bool = true) {
        constraint = cons
        
        self.maxFollowPoint = -maxFollowPoint
        self.minFollowPoint = minFollowPoint
        
        self.allowHalfDisplay = allowHalfDisplay
    }
    
    func setupDelayPoints(pointOfStartingHiding hidingPoint: CGFloat, pointOfStartingShowing showingPoint: CGFloat) {
        pointOfStartingHiding = -hidingPoint
        pointOfStartingShowing = showingPoint
    }
    
    func didScroll(_ scrollView: UIScrollView) {
        let currentPoint = -scrollView.contentOffset.y
        
        let differencePoint = currentPoint - previousPoint
        let nextPoint = constraint.constant + differencePoint
        let nextDelayBuffer = delayBuffer + differencePoint
        
        if isTopOrBottomEdge(scrollView) { return }
        
        // Checking delay.
        // pointOfStartingHiding < nextDelayBuffer < pointOfStartingShowing
        if pointOfStartingHiding < nextDelayBuffer && pointOfStartingShowing > nextDelayBuffer {
            
            if nextDelayBuffer < pointOfStartingHiding {
                delayBuffer = pointOfStartingHiding
            } else if nextDelayBuffer > pointOfStartingShowing {
                delayBuffer = pointOfStartingShowing
            } else {
                delayBuffer += differencePoint
            }
            
        } else { // Scrolling Header View.
            
            if nextPoint < maxFollowPoint {
                constraint.constant = maxFollowPoint
            } else if nextPoint > minFollowPoint {
                constraint.constant = minFollowPoint
            } else {
                constraint.constant += differencePoint
            }
            
        }
        
        layoutIfNeeded()
        
        previousPoint = currentPoint
    }
    
    func didEndScrolling(_ willDecelerate: Bool = false) {
        if !willDecelerate && !allowHalfDisplay {
            showOrHideIfNeeded()
        }
    }
    
    private func showOrHideIfNeeded() {
        if constraint.constant < maxFollowPoint - maxFollowPoint/2 {
            hide(true)
        } else {
            show(true)
        }
    }
    
    private func isTopOrBottomEdge(_ scrollView: UIScrollView) -> Bool {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height || scrollView.contentOffset.y <= 0 {
            return true
        }
        
        return false
    }
    
}

// MARK: - ManageProperties
extension HeaderScrollingView {
    public func resetPreviousPoint(_ scrollView: UIScrollView) {
        previousPoint = -scrollView.contentOffset.y
    }
    
    public func resetDelayBuffer(_ scrollView: UIScrollView) {
        delayBuffer = -scrollView.contentOffset.y
    }
}

// MARK: - ShowAndHide
extension HeaderScrollingView {
    public func show(_ animated: Bool, duration: Double = 0.2, completionHandler: (()->())? = nil) {
        superview?.layoutIfNeeded()
        
        if animated {
            UIView.animate(withDuration: duration, animations: { [weak self] in
                guard let `self` = self else { return }
                self.constraint.constant = self.minFollowPoint
                self.superview?.layoutIfNeeded()
                }, completion: { _ in
                    completionHandler?()
            })
        } else {
            constraint.constant = minFollowPoint
            superview?.layoutIfNeeded()
            completionHandler?()
        }
    }
    
    public func hide(_ animated: Bool, duration: Double = 0.2, completionHandler: (()->())? = nil) {
        superview?.layoutIfNeeded()
        
        if animated {
            UIView.animate(withDuration: duration, animations: { [weak self] in
                guard let `self` = self else { return }
                self.constraint.constant = self.maxFollowPoint
                self.superview?.layoutIfNeeded()
                }, completion: { _ in
                    completionHandler?()
            })
        } else {
            constraint.constant = maxFollowPoint
            superview?.layoutIfNeeded()
            completionHandler?()
        }
    }
}
