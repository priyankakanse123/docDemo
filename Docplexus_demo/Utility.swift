//
//  Utility.swift
//  Docplexus_demo
//
//  Created by Priyanka Kanse on 15/03/18.
//  Copyright © 2018 Priyanka Kanse. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    //make image view Round
    class func makeImgViewRound(imgView : UIImageView)
    {
        imgView.layer.cornerRadius = imgView.frame.height/2
    }
    
    //make a border width
    class func drawBorder(customView:UIView,borderColor:UIColor,borderWidth:CGFloat = 1.0)
    {
        customView.layer.borderColor = borderColor.cgColor
        customView.layer.borderWidth = borderWidth
    }
    
}

//extension to change multiplier
extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
}
}
