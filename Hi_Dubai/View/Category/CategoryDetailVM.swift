//
//  CategoryDetailVM.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 25/07/2023.
//

import Foundation
import Foundation
import SwiftyJSON
import UIKit
protocol CategoryDetailVMDelegate: NSObject {
    func willHitSuperYouApi()
    func getSuperYouDataSuccess(successMsg: String, isPullToRefresh: Bool, lastPageScrolled: Int)
}

extension CategoryDetailVMDelegate{
    func willHitSuperYouApi(){}
    func getSuperYouDataSuccess(successMsg: String, isPullToRefresh: Bool, lastPageScrolled: Int){}
}
class CategoryDetailVM {
    
    weak var delegate: CategoryDetailVMDelegate?
    var categoryData: CategoryDetailModel? = CategoryDetailModel(nextPageStatus: true)
    var nextPageStatus: Bool = false
    var firstTimeApiCompletion: Bool = false
    var page: Int = 0
    private var isDataLoadedFromLocalDB: Bool = false
    var apiHitCount: Int = 0
}
