//
//  PageMenuViewController.swift
//  Docplexus_demo
//
//  Created by Priyanka Kanse on 16/03/18.
//  Copyright © 2018 Priyanka Kanse. All rights reserved.
//

import UIKit
import PageMenu

class PageMenuViewController: UIViewController {
    
    var pageMenu : CAPSPageMenu?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        // Create variables for all view controllers you want to put in the
        // page menu, initialize them, and add each to the controller array.
        // (Can be any UIViewController subclass)
        // Make sure the title property of all view controllers is set
        // Add Post
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller : ViewController = storyboard.instantiateViewController(withIdentifier: "postVC") as! ViewController
        controller.title = "POSTS"
        controllerArray.append(controller)
        
        //Profile
        let profileVc : ProfileViewController = storyboard.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
        profileVc.title = "PROFILE"
        controllerArray.append(profileVc)

        
        //Addnotification
        let notificationVc : NotificationViewController = storyboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationViewController
        notificationVc.title = "NOTIFICATION"
        controllerArray.append(notificationVc)
        
        //guideline
        let guidelineVc : GuidelineViewController = storyboard.instantiateViewController(withIdentifier: "guidelineVC") as! GuidelineViewController
        guidelineVc.title = "GUIDELINE"
        controllerArray.append(guidelineVc)

        

        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(0),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .scrollMenuBackgroundColor(Constant.Color.darkBlueColor),
            .addBottomMenuHairline(true),
            .menuHeight(64.0)
            
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x:0.0, y:0.0, width:self.view.frame.width, height:self.view.frame.height), pageMenuOptions: parameters)
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.view.addSubview(pageMenu!.view)
       
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
