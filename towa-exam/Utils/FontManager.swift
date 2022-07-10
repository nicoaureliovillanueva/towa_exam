//
//  FontManager.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/5/22.
//

import Foundation
import UIKit

struct FontManager {
    
    enum FontName: String {
        case helveticaNeue = "HelveticaNeue"
        case helveticaNeueBold = "HelveticaNeue-Bold"
    }
    
    enum FontSize: CGFloat {
        case xxxLargeTitle = 30
        case extraLargeTitle = 25
        case xxLargeTitle = 20
        case title = 18
        case subTitle = 16
        case regular = 14
        case smallText = 12
    }
    
    
    static let xxxLargeTitle = UIFont(name: FontName.helveticaNeueBold.rawValue,
                                   size: FontSize.xxxLargeTitle.rawValue)
    
    static let extraLarge = UIFont(name: FontName.helveticaNeueBold.rawValue,
                                   size: FontSize.extraLargeTitle.rawValue)
    
    static let xxLargeTitle = UIFont(name: FontName.helveticaNeueBold.rawValue,
                                   size: FontSize.xxLargeTitle.rawValue)
    
    static let regular = UIFont(name: FontName.helveticaNeue.rawValue,
                                size: FontSize.regular.rawValue)
    
    static let bold = UIFont(name: FontName.helveticaNeueBold.rawValue,
                             size: FontSize.regular.rawValue)
    
    static let title = UIFont(name: FontName.helveticaNeueBold.rawValue,
                              size: FontSize.title.rawValue)
    
    static let titleNormal = UIFont(name: FontName.helveticaNeue.rawValue,
                                  size: FontSize.title.rawValue)
    
    static let subTitle = UIFont(name: FontName.helveticaNeue.rawValue,
                                 size: FontSize.subTitle.rawValue)
    
    
    static let smallText = UIFont(name: FontName.helveticaNeue.rawValue,
                                 size: FontSize.smallText.rawValue)
        
}
