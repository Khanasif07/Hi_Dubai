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
var promoDealsSectionHeight:CGFloat = 82.0  // section 1
var fireworkViewCurrentHeight: CGFloat = 233.0
let DEALSSECTIONHEIGHT: CGFloat = 233 + 50.0 + 3.0   // view Height + header height + bottom seperator height
let FEATUREDARTICLESSECTIONHEIGHT: CGFloat = 260.0 + 50.0 + 3.0
var featuredArticlesViewCurrentHeight: CGFloat = 1000.0
//let TopicSectionCurrentHeight:CGFloat = 326.0// section 2 // 50+273+3
let TopicSectionCurrentHeight:CGFloat = 80.0// section 2 // 50+273+3
let trendingSectionHeight:CGFloat = 614.0 // section 3
let trendingSectionHeaderHeight:CGFloat = 48.0 // section 3

var SCROLL_BREAK_POINT_1: CGFloat {
    return  TopicSectionCurrentHeight // trending
    //return 547.0
}

var SCROLL_BREAK_POINT_2: CGFloat {
    return  TopicSectionCurrentHeight + trendingSectionHeight // 7.0 extra space to go underneath
    //return 1171.0
}

var SCROLL_BREAK_POINT_fireWorkSectionInitial: CGFloat {
    return promoDealsSectionHeight + TopicSectionCurrentHeight + trendingSectionHeaderHeight + trendingSectionHeight
    //return 1212.0  //547+48 +614+3
}

var SCROLL_BREAK_POINT_fireWorkSectionFinal: CGFloat {
    return promoDealsSectionHeight + TopicSectionCurrentHeight + trendingSectionHeaderHeight + trendingSectionHeight + fireworkViewCurrentHeight + 3
    //233 = height of video container view
    //return 1398.0 + 53.0
}

var SCROLL_BREAK_POINT_FeaturedArticlesSectionInitial: CGFloat {
    return promoDealsSectionHeight + TopicSectionCurrentHeight + trendingSectionHeaderHeight + trendingSectionHeight  + fireworkViewCurrentHeight + 3 + 48.0
}

var SCROLL_BREAK_POINT_FeaturedArticlesSectionFinal: CGFloat {
    return promoDealsSectionHeight + TopicSectionCurrentHeight + trendingSectionHeaderHeight + trendingSectionHeight  + fireworkViewCurrentHeight + 260.0 + 3 + 48.0 + 3.0
    //260 = height of deals container view
}

var SCROLL_BREAK_POINT_DealsSectionInitial: CGFloat {
    return promoDealsSectionHeight + TopicSectionCurrentHeight + trendingSectionHeaderHeight + trendingSectionHeight  + fireworkViewCurrentHeight + 260.0 + 3.0 + 48.0 + 3.0 +  48.0
}

var SCROLL_BREAK_POINT_DealsSectionFinal: CGFloat {
    return promoDealsSectionHeight + TopicSectionCurrentHeight + trendingSectionHeaderHeight + trendingSectionHeight  + fireworkViewCurrentHeight + featuredArticlesViewCurrentHeight + 260.0 + 3.0 + 48.0 +  90.0 + 3.0 + 48.0
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
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var searchTextField: NewSearchTextField!
    @IBOutlet weak var dealsView: UIView!
    @IBOutlet weak var topBigView: UIView!
    @IBOutlet weak var fakeNavBar: UIImageView!
    @IBOutlet var realTabBar1: UIView!
    @IBOutlet var realTabBarFeaturedArticlesSectionTitleView: UIView!
    @IBOutlet var realTabBarFireworkSectionTitleView: UIView!
    @IBOutlet weak var fakeTabBarFeaturedDealsSectionTitleView: UIView!
    @IBOutlet weak var fakeTabBarFeaturedArticlesSectionTitleView: UIView!
    @IBOutlet weak var fakeTabBarFireworkSectionTitleView: UIView!
    @IBOutlet weak var fakeTabBar1: UIView!
    @IBOutlet var realTabBarLastSectionTitleView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerStackView: UIStackView!
    
    var emptyViewPersonal: EmptyView?
    var emptyView: EmptyStateView? = EmptyStateView.instanciateFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = false
        scrollView.delegate = self
        searchTextField.delegate = self
        searchTextField.setPlaceholder(placeholder: "Find Malls, Shops, Hotels...")
        cancelBtn.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        //realTabBarLastSectionTitleView
        let yyyValue = (self.fakeTabBarFeaturedDealsSectionTitleView.frame.origin.y) + (self.scrollView.frame.origin.y) + TOOLBAR_DEFAULT_HEIGHT
        realTabBarLastSectionTitleView.frame = CGRect(x: 0.0, y: yyyValue, width: fakeTabBarFeaturedDealsSectionTitleView.frame.size.width, height: fakeTabBarFeaturedDealsSectionTitleView.frame.size.height)
        print("realTabBarFeaturedArticlesSectionTitleView frame =\(realTabBarLastSectionTitleView.frame)")
        view.addSubview(realTabBarLastSectionTitleView)
        view.bringSubviewToFront(fakeNavBar)
        
        // Custom way to add view
        let frame = CGRect(x: 0, y: 0, width: dealsView.width, height: dealsView.height)
        emptyView?.frame = frame
        emptyView?.show()
        self.dealsView.addSubview(self.emptyView!)
        
        // Custom way to add view
        if emptyViewPersonal != nil {
            emptyViewPersonal?.hide()
        } else{
            emptyViewPersonal = EmptyView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.topBigView.frame.width, height: self.topBigView.frame.height)), inView: topBigView, centered: true, icon: UIImage(named: ""), message: "")
            emptyViewPersonal?.show()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 1), animated: true)
    }
    
    @IBAction func cancelSearch(_ sender: Any?) {
        closeSearchingArea(true)
        self.view.endEditing(true)
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
        /*========  featured Articles section End ========= */
        
        /*======== Deals section start ========= */
        //Deals section
        if yOffset < SCROLL_BREAK_POINT_DealsSectionInitial {
            realTabBarLastSectionTitleView.frame = CGRect(x: 0, y: fakeTabBarFeaturedDealsSectionTitleView.frame.origin.y + self.scrollView.frame.origin.y - CGFloat(yOffset), width: fakeTabBarFeaturedDealsSectionTitleView.frame.size.width, height: fakeTabBarFeaturedDealsSectionTitleView.frame.size.height)
            print("realTabBarDealsSectionTitleView.frame 1= \(realTabBarLastSectionTitleView.frame)")
        } else if yOffset >= SCROLL_BREAK_POINT_DealsSectionInitial && yOffset < SCROLL_BREAK_POINT_DealsSectionFinal {
            realTabBarLastSectionTitleView.frame = CGRect(x: 0, y: TOP_ANCHOR_POINT, width: fakeTabBarFeaturedDealsSectionTitleView.frame.size.width, height: fakeTabBarFeaturedDealsSectionTitleView.frame.size.height)
            print("realTabBarDealsSectionTitleView.frame 2= \(realTabBarLastSectionTitleView.frame)")
        } else {
            
            realTabBarLastSectionTitleView.frame = CGRect(x: 0, y: CGFloat(TOP_ANCHOR_POINT - (yOffset - SCROLL_BREAK_POINT_DealsSectionFinal)), width: fakeTabBarFeaturedDealsSectionTitleView.frame.size.width, height: fakeTabBarFeaturedDealsSectionTitleView.frame.size.height)
            print("realTabBarDealsSectionTitleView.frame 3= \(realTabBarLastSectionTitleView.frame)")
        }
        
        /*======== Deals section end ========= */
    }
    
    //    func showEmptyView() {
    //        emptyView = EmptyStateView(whitFrame: topBigView.frame, in: topBigView, centered: true, icon: UIImage(named: "ogimage-hidubai"), message: "There are no results for your search. Try again!", showLoginBtn: false)
    //        emptyView?.show()
    //    }
    
    func closeSearchingArea(_ isTrue: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0.0,options: .curveEaseInOut) {
            self.cancelBtn.isHidden = isTrue
            self.searchTextField.cancelBtn.isHidden = isTrue
            self.searchTextField.crossBtnWidthConstant.constant = isTrue ? 0.0 : 50.0
            self.searchTextField.layoutIfNeeded()
        } completion: { value in
//            self.searchTextField.cancelBtn.isHidden = isTrue
        }
    }
    
}

// MARK: - WalifSearchTextFieldDelegate
extension ExploreViewController: WalifSearchTextFieldDelegate{
    func walifSearchTextFieldBeginEditing(sender: NewSearchTextField!) {
        closeSearchingArea(false)
    }
    
    func walifSearchTextFieldEndEditing(sender: NewSearchTextField!) {
        closeSearchingArea(true)
    }
    
    func walifSearchTextFieldChanged(sender: NewSearchTextField!) {
        print(sender.text())
    }
    
    func walifSearchTextFieldIconPressed(sender: NewSearchTextField!) {
        closeSearchingArea(true)
        print(sender.text())
    }
    
    
}
