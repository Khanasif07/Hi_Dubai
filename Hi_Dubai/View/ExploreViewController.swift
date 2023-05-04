//
//  ExploreViewController.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 02/05/2023.
//

import UIKit
//
//(lldb) po SCROLL_BREAK_POINT_fireWorkSectionFinal
//1058.0
//
//(lldb) po SCROLL_BREAK_POINT_fireWorkSectionInitial
//822.0
//
//topPaddingRef = 47.0
//realTabBarFireworkSectionTitleView.frame 2= (0.0, 47.0, 390.0, 50.0)
//(lldb) po SCROLL_BREAK_POINT_FeaturedArticlesSectionInitial
//822.0
//
//(lldb) po SCROLL_BREAK_POINT_FeaturedArticlesSectionFinal
//1345.0
//
//(lldb) po SCROLL_BREAK_POINT_1
//80.0
//
//(lldb) po SCROLL_BREAK_POINT_2
//694.0
//

let TOOLBAR_DEFAULT_HEIGHT: CGFloat = 50.0
//let TOP_ANCHOR_POINT: CGFloat = 0.0 + 47.0
var promoDealsSectionHeight:CGFloat = 80.0  // section 1
var fireworkViewCurrentHeight: CGFloat = 233.0
//let DEALSSECTIONHEIGHT: CGFloat = 233 + 50.0 + 3.0   // view Height + header height + bottom seperator height
let FEATUREDARTICLESSECTIONHEIGHT: CGFloat = 260.0 + 50.0 + 3.0
var featuredArticlesViewCurrentHeight: CGFloat = 0
//let TopicSectionCurrentHeight:CGFloat = 326.0// section 2 // 50+273+3
let TopicSectionCurrentHeight:CGFloat = 80.0// section 2 // 50+273+3
let trendingSectionHeight:CGFloat = 614.0 // section 3
let trendingSectionHeaderHeight:CGFloat = 48.0 // section 3
let trendingSectionSeperatorHeight:CGFloat = 0.0 // section 3

var SCROLL_BREAK_POINT_1: CGFloat {
    return  TopicSectionCurrentHeight // trending
    //return 547.0
}

var SCROLL_BREAK_POINT_2: CGFloat {
    return  TopicSectionCurrentHeight + trendingSectionHeight + trendingSectionSeperatorHeight + 0.0 // 7.0 extra space to go underneath
    //return 1171.0
}

var SCROLL_BREAK_POINT_fireWorkSectionInitial: CGFloat {
    return promoDealsSectionHeight + TopicSectionCurrentHeight + trendingSectionHeaderHeight + trendingSectionHeight + trendingSectionSeperatorHeight
    //return 1212.0  //547+48 +614+3
}

var SCROLL_BREAK_POINT_fireWorkSectionFinal: CGFloat {
    return promoDealsSectionHeight + TopicSectionCurrentHeight + trendingSectionHeaderHeight + trendingSectionHeight + trendingSectionSeperatorHeight + fireworkViewCurrentHeight + 3
    //233 = height of video container view
    //return 1398.0 + 53.0
}

var SCROLL_BREAK_POINT_FeaturedArticlesSectionInitial: CGFloat {
    return promoDealsSectionHeight + TopicSectionCurrentHeight + trendingSectionHeaderHeight + trendingSectionHeight + trendingSectionSeperatorHeight + fireworkViewCurrentHeight + 3 + 50.0
}

var SCROLL_BREAK_POINT_FeaturedArticlesSectionFinal: CGFloat {
    return promoDealsSectionHeight + TopicSectionCurrentHeight + trendingSectionHeaderHeight + trendingSectionHeight + trendingSectionSeperatorHeight + fireworkViewCurrentHeight + 520.0 + 3
    //260 = height of deals container view
}

var TOP_ANCHOR_POINT:CGFloat {
    
    let extraTopSpace:CGFloat = 0.0
    var topPaddingRef:CGFloat = 20.0 + extraTopSpace
    if #available(iOS 13.0, *) {
        let window = UIApplication.shared.windows.first
        if let topPadding = window?.safeAreaInsets.top{
            topPaddingRef = topPadding + extraTopSpace
        }
    }
    print("topPaddingRef = \(topPaddingRef)")
    return topPaddingRef
}

class ExploreViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var fakeNavBar: UIImageView!
    @IBOutlet var realTabBarDealsSectionTitleView: UIView!
    @IBOutlet var realTabBar1: UIView!
    @IBOutlet var realTabBarFeaturedArticlesSectionTitleView: UIView!
    @IBOutlet var realTabBarFireworkSectionTitleView: UIView!
    @IBOutlet weak var fakeTabBarFeaturedDealsSectionTitleView: UIView!
    @IBOutlet weak var fakeTabBarFeaturedArticlesSectionTitleView: UIView!
    @IBOutlet weak var fakeTabBarFireworkSectionTitleView: UIView!
    @IBOutlet weak var fakeTabBar1: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        //realTabBar1
        realTabBar1.frame = CGRect(x: 0, y: fakeTabBar1.frame.origin.y + scrollView.frame.origin.y, width: view.frame.size.width, height: fakeTabBar1.frame.size.height)
        print("realTabBar1 frame =\(fakeTabBar1.frame)")
        view.addSubview(realTabBar1)
        //realTabBarFireworkSectionTitleView
        let yValue = (self.fakeTabBarFireworkSectionTitleView.frame.origin.y) + (self.scrollView.frame.origin.y) + TOOLBAR_DEFAULT_HEIGHT
        realTabBarFireworkSectionTitleView.frame = CGRect(x: 0.0, y: yValue, width: fakeTabBarFireworkSectionTitleView.frame.size.width, height: fakeTabBarFireworkSectionTitleView.frame.size.height)
        print("realTabBarFireworkSectionTitleView frame =\(realTabBarFireworkSectionTitleView.frame)")
        view.addSubview(realTabBarFireworkSectionTitleView)
        //realTabBarFeaturedArticlesSectionTitleView
        let yyValue = (self.fakeTabBarFeaturedArticlesSectionTitleView.frame.origin.y) + (self.scrollView.frame.origin.y) + TOOLBAR_DEFAULT_HEIGHT
        realTabBarFeaturedArticlesSectionTitleView.frame = CGRect(x: 0.0, y: yyValue, width: fakeTabBarFeaturedArticlesSectionTitleView.frame.size.width, height: fakeTabBarFeaturedArticlesSectionTitleView.frame.size.height)
        print("realTabBarFeaturedArticlesSectionTitleView frame =\(realTabBarFeaturedArticlesSectionTitleView.frame)")
        view.addSubview(realTabBarFeaturedArticlesSectionTitleView)
        view.bringSubviewToFront(fakeNavBar)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 1), animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yOffset = scrollView.contentOffset.y
        print("yOffset = \(yOffset)")
        // first tab bar
        if yOffset < SCROLL_BREAK_POINT_1 {
            realTabBar1.frame = CGRect(x: 0, y: fakeTabBar1.frame.origin.y + self.scrollView.frame.origin.y - CGFloat(yOffset), width: fakeTabBar1.frame.size.width, height: fakeTabBar1.frame.size.height)
            print("realTabBar1.frame 1= \(realTabBar1.frame)")
        } else if yOffset >= SCROLL_BREAK_POINT_1 && yOffset < SCROLL_BREAK_POINT_2 {
            realTabBar1.frame = CGRect(x: 0, y: TOP_ANCHOR_POINT, width: fakeTabBar1.frame.size.width, height: fakeTabBar1.frame.size.height)
            print("realTabBar1.frame 2= \(realTabBar1.frame)")
        } else {
            
            realTabBar1.frame = CGRect(x: 0, y: CGFloat(TOP_ANCHOR_POINT - (yOffset - SCROLL_BREAK_POINT_2)), width: fakeTabBar1.frame.size.width, height: fakeTabBar1.frame.size.height)
            
            print("realTabBar1.frame 3= \(realTabBar1.frame)")
        }
        
        
        /*======== firework section start ========= */
        //Firework section
        if yOffset < SCROLL_BREAK_POINT_fireWorkSectionInitial {
            realTabBarFireworkSectionTitleView.frame = CGRect(x: 0, y: fakeTabBarFireworkSectionTitleView.frame.origin.y + self.scrollView.frame.origin.y - CGFloat(yOffset), width: fakeTabBarFireworkSectionTitleView.frame.size.width, height: fakeTabBarFireworkSectionTitleView.frame.size.height)
            print("realTabBarFireworkSectionTitleView.frame 1= \(realTabBarFireworkSectionTitleView.frame)")
        } else if yOffset >= SCROLL_BREAK_POINT_fireWorkSectionInitial && yOffset < SCROLL_BREAK_POINT_fireWorkSectionFinal {
            realTabBarFireworkSectionTitleView.frame = CGRect(x: 0, y: TOP_ANCHOR_POINT, width: fakeTabBarFireworkSectionTitleView.frame.size.width, height: fakeTabBarFireworkSectionTitleView.frame.size.height)
            print("realTabBarFireworkSectionTitleView.frame 2= \(realTabBarFireworkSectionTitleView.frame)")
        } else {
            
            realTabBarFireworkSectionTitleView.frame = CGRect(x: 0, y: CGFloat(TOP_ANCHOR_POINT - (yOffset - SCROLL_BREAK_POINT_fireWorkSectionFinal)), width: fakeTabBarFireworkSectionTitleView.frame.size.width, height: fakeTabBarFireworkSectionTitleView.frame.size.height)
            print("realTabBarFireworkSectionTitleView.frame 3= \(realTabBarFireworkSectionTitleView.frame)")
        }
        
        /*======== firework section end ========= */
        
        /*========  featured Articles section start ========= */
        //Deals section
        if yOffset < SCROLL_BREAK_POINT_FeaturedArticlesSectionInitial {
            realTabBarFeaturedArticlesSectionTitleView.frame = CGRect(x: 0, y: fakeTabBarFeaturedArticlesSectionTitleView.frame.origin.y + self.scrollView.frame.origin.y - CGFloat(yOffset), width: fakeTabBarFeaturedArticlesSectionTitleView.frame.size.width, height: fakeTabBarFeaturedArticlesSectionTitleView.frame.size.height)
            print("realTabBarFeaturedArticlesSectionTitleView.frame 1= \(realTabBarFeaturedArticlesSectionTitleView.frame)")
        } else if yOffset >= SCROLL_BREAK_POINT_FeaturedArticlesSectionInitial && yOffset < SCROLL_BREAK_POINT_FeaturedArticlesSectionFinal {
            realTabBarFeaturedArticlesSectionTitleView.frame = CGRect(x: 0, y: TOP_ANCHOR_POINT, width: fakeTabBarFeaturedArticlesSectionTitleView.frame.size.width, height: fakeTabBarFeaturedArticlesSectionTitleView.frame.size.height)
            print("realTabBarFeaturedArticlesSectionTitleView.frame 2= \(realTabBarFeaturedArticlesSectionTitleView.frame)")
        } else {
            
            realTabBarFeaturedArticlesSectionTitleView.frame = CGRect(x: 0, y: CGFloat(TOP_ANCHOR_POINT - (yOffset - SCROLL_BREAK_POINT_FeaturedArticlesSectionFinal)), width: fakeTabBarFeaturedArticlesSectionTitleView.frame.size.width, height: fakeTabBarFeaturedArticlesSectionTitleView.frame.size.height)
            print("realTabBarFeaturedArticlesSectionTitleView.frame 3= \(realTabBarFeaturedArticlesSectionTitleView.frame)")
        }
    }

}
