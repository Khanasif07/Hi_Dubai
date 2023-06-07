//
//  Configuration.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 07/06/2023.
//

import Foundation
import UIKit

public enum PList: Int {
    
    case buildType
    case firTimeInterval
    case handOffBundleId

    func value() -> String {
        switch self {
        case .buildType:
            return "BUILD_TYPE"
        case .firTimeInterval:
            return "FIRTimeInterval"
        case .handOffBundleId:
            return "HandOffBundleId"
        }
    }
}

open class Environment: NSObject {
    public static var shared = Environment()

   public var isForceUpdateOnScreen: Bool = false

   open func configuration(_ key: PList) -> String {
        if let infoDict = Bundle.main.infoDictionary {
            switch key {
            case .buildType:
                return infoDict[PList.buildType.value()] as? String ?? ""
            case .firTimeInterval:
                return infoDict[PList.firTimeInterval.value()] as? String ?? ""
            case .handOffBundleId:
                return infoDict[PList.handOffBundleId.value()] as? String ?? ""
            }
        } else {
            fatalError("Unable to locate plist file")
        }
    }
}


