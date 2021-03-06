//
//  ViewController.swift
//  Docplexus_demo
//
//  Created by Priyanka Kanse on 15/03/18.
//  Copyright © 2018 Priyanka Kanse. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,PCallback {
    
    @IBOutlet weak var postTableView: UITableView!
    var presenterObj : Presenter?                           //declare presenter obj
    var postObjListArray = [Model]()                        //stores data to be displayed

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.presenterObj = Presenter(pCallback: self)      //declare presenter obj
        self.presenterObj?.readJsonFile()                   //call presenter to read json

    }
    
    //make view setup
    func setUpView()
    {
        //tableview auto adjustble height
        self.postTableView.estimatedRowHeight = 65
        self.postTableView.rowHeight = UITableViewAutomaticDimension
        
        //remove tableview row seperator
        self.postTableView.separatorStyle = .none
        
        //disable tableview
        self.postTableView.allowsSelection = false
        
    }
    
    //MARK:-tableview data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(postObjListArray.count)
        return postObjListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! ProfileTableViewCell
        
        let currentPostModelObj = self.postObjListArray[indexPath.row]
        
        //profile details
        
        //profile image
        Utility.makeImgViewRound(imgView: cell.profileImgView)          //round profile image
        cell.profileImgView.image = UIImage(named: "defaultProfile")    //set default profileImg
        if(currentPostModelObj.user?.thumbnailUrl != nil)
        {
            cell.profileImgView.downloadedFrom(link: (currentPostModelObj.user?.thumbnailUrl!)!)
        }
        //profile name
        if(currentPostModelObj.user?.authorName != nil)
        {
            cell.autherName.text = currentPostModelObj.user?.authorName!
        }
        else
        {
            cell.autherName.text = ""
            cell.autherName.isHidden = true
        }
        
        //get time difference
        if(currentPostModelObj.creationDate != nil)
        {
            cell.queryPostedTimeLbl.text = self.presenterObj?.getTimeInString(postedTimeInString: currentPostModelObj.creationDate!)
        }
        else
        {
            cell.queryPostedTimeLbl.text = "NA" //stands for not availiable
        }
    
        //article info
        //article Logo
        if(currentPostModelObj.typeName?.lowercased() == "question")        //question
        {
            cell.queryImgView.image = UIImage(named: "questnNoteIcon")
        }
        else if(currentPostModelObj.typeName?.lowercased() == "article")    //article
        {
            cell.queryImgView.image = UIImage(named: "articleIcon")
        }
        else                                                                //default news
        {
            cell.queryImgView.image = UIImage(named: "newsIcon")
        }
        
        //assign title
        if(currentPostModelObj.title != nil)
        {
            cell.titleStatmntLabl.text = currentPostModelObj.title!
        }
        else
        {
            cell.titleStatmntLabl.text = ""
            cell.titleStatmntLabl.isHidden = true
        }
        
        //assign article short body
        if(currentPostModelObj.shortBodyText != nil)
        {
            cell.descriptnLable.text = currentPostModelObj.shortBodyText!
        }
        else
        {
            cell.descriptnLable.text = ""
            cell.descriptnLable.isHidden = true
        }
        cell.postImgView.image = nil
        //cell.queryImgAspectRatio = cell.queryImgAspectRatio.setMultiplier(multiplier: 1.5)
        NSLayoutConstraint.activate([cell.queryImgAspectRatio])
        //assign post image
        if(currentPostModelObj.featuredAttachmentUrl != nil)
        {
            let multiplier = CGFloat(CGFloat(currentPostModelObj.featuredAttachmentWidth!)/CGFloat(currentPostModelObj.featuredAttachmentHeigth!))                      //set image ration dynamically
            cell.queryImgAspectRatio = cell.queryImgAspectRatio.setMultiplier(multiplier:multiplier)
            cell.postImgView.downloadedFrom(link: currentPostModelObj.featuredAttachmentUrl!)
        }
        else
        {
            cell.descrTopHeightConstrain.constant = 0
            cell.postImgView.backgroundColor = UIColor.clear
            cell.queryImgAspectRatio = cell.queryImgAspectRatio.setMultiplier(multiplier:650)

        }
        
        //button attributes
        Utility.drawBorder(customView: cell.viewButtn, borderColor: Constant.Color.lightGrayColor)
        Utility.drawBorder(customView: cell.voteButtn, borderColor: Constant.Color.lightGrayColor)
        Utility.drawBorder(customView: cell.commentButtn, borderColor: Constant.Color.lightGrayColor)
        
        //button data
        if(currentPostModelObj.viewCount != nil)
        {
            cell.viewButtn.setTitle("\(String(describing: currentPostModelObj.viewCount!)) View", for: .normal)
        }
        if(currentPostModelObj.voteCount != nil)
        {
            cell.voteButtn.setTitle("\(String(describing: currentPostModelObj.voteCount!)) Vote", for: .normal)
        }
        if(currentPostModelObj.answerCount != nil)
        {
            cell.commentButtn.setTitle("\(String(describing: currentPostModelObj.answerCount!)) Vote", for: .normal)
        }

        //view borde
        Utility.drawBorder(customView: cell.innerView, borderColor:  Constant.Color.darkGrayBorderColor)
        
        //set post topics
        // create attributed string
        
        let myAttrString = NSMutableAttributedString()
        for item in currentPostModelObj.therapeutics
        {
            let myString = item.name!
            var myAttribute = [NSBackgroundColorAttributeName: Constant.Color.lightBlueColor]       //make background color blue
            myAttrString.append(NSMutableAttributedString(string: myString, attributes: myAttribute))
            
            let whiteSpaceString = " "
            myAttribute = [NSBackgroundColorAttributeName: UIColor.white]         //put white background string to seperate
            myAttrString.append(NSMutableAttributedString(string: whiteSpaceString, attributes: myAttribute))

        }
        
        // set attributed text on a UILabel
        cell.diseaseInfoLbl.attributedText = myAttrString
        
        return cell
    }
    //MARK:-tableview Delegate

    
    
    //MARK:-implement callback protocol
    func showError(errorMessage:String)
    {
        //display error code
    }
    func sucessCallBack(postArray:[Model])
    {
        self.postObjListArray.removeAll()
        self.postObjListArray = postArray
        
        //refresh tableview
        self.postTableView.reloadData()
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

