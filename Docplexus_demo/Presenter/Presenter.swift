//
//  Presenter.swift
//  Docplexus_demo
//
//  Created by Priyanka Kanse on 16/03/18.
//  Copyright © 2018 Priyanka Kanse. All rights reserved.
//

import UIKit

protocol PCallback
{
    func showError(errorMessage:String)
    func sucessCallBack(postArray:[Model])
}

class Presenter: NSObject {
    
    //stores post objects
    var listObjArray = [Model]()
    
    //protocol obj
    var delegate : PCallback?
    
    init(pCallback:PCallback)
    {
        //pass ref object
        self.delegate = pCallback
    }
    
    //read json
    func readJsonFile()
    {
        if let path = Bundle.main.path(forResource: "posts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                print(jsonResult)
                if jsonResult is NSArray {
                    self.parseJsonData(dataArray:jsonResult as! NSArray)
                }
                else
                {
                    self.delegate?.showError(errorMessage:Constant.ErrorTypes.incorrectDataFormat)
                }
            } catch {
                self.delegate?.showError(errorMessage:Constant.ErrorTypes.incorrectDataFormat)
            }
        }
        else
        {
            self.delegate?.showError(errorMessage:Constant.ErrorTypes.dataNotFound)
        }

    }
    
    //parse Json object
    func parseJsonData(dataArray:NSArray)
    {
        self.listObjArray = [Model]()
        for postItem in dataArray
        {
            if(postItem is NSDictionary)
            {
                let postItemDict = postItem as! NSDictionary
                let postModelObj = Model(jsonDict: postItemDict)
                self.listObjArray.append(postModelObj)
            }
            else
            {
                self.delegate?.showError(errorMessage:Constant.ErrorTypes.incorrectDataFormat)
            }
        }
        
        //send a callback to view
        self.delegate?.sucessCallBack(postArray: self.listObjArray)
    }
    
    //get time difference in terms of her
    func getTimeInString(postedTimeInString:String)->String
    {
        let startDate = self.convertToDate(dateString: postedTimeInString)
        
        let components:[Calendar.Component] = [.hour, .minute , .year , .month , .day]
        let calendar = Calendar.current
        let timeDifference = calendar.dateComponents(Set<Calendar.Component>(components),
                                                     from: startDate, to: Date())
        
        print(timeDifference)
        let timeToShow = self.passTimeDifferenceProperty(timeDifference: timeDifference)
    
        return timeToShow
    }
    
    // Convert String to Date
    func convertToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S" // date format
        let serverDate: Date = dateFormatter.date(from: dateString)! // according to date format date string
        return serverDate
    }
    
    //pass time string to display
    func passTimeDifferenceProperty(timeDifference:DateComponents) -> String
    {
        //check if year more than 1
        if(timeDifference.year!>0)
        {
            if(timeDifference.year == 1)
            {
                return "\(String(describing: timeDifference.year!)) year ago"      //1 year
            }
            else
            {
                return "\(String(describing: timeDifference.year!)) years ago"    // more than 1 year
            }
        }
        //check for months
        else if(timeDifference.month!<12 && timeDifference.month!>0)
        {
            if(timeDifference.year == 1)
            {
                return "\(String(describing: timeDifference.month!)) month ago"      //1 month
            }
            else
            {
                return "\(String(describing: timeDifference.month!)) months ago"    // more than 1 month
            }

        }
        //check for hours
        else if(timeDifference.hour!<24 && timeDifference.hour!>0)
        {
            if(timeDifference.year == 1)
            {
                return "\(String(describing: timeDifference.hour!)) hour ago"      //1 hour
            }
            else
            {
                return "\(String(describing: timeDifference.hour!)) hours ago"    // more than 1 hour
            }
        }
        
        //check for minutes
        else if(timeDifference.minute!<60 && timeDifference.minute!>0)
        {
            if(timeDifference.year == 1)
            {
                return "\(String(describing: timeDifference.minute!)) minute ago"      //1 minute
            }
            else
            {
                return "\(String(describing: timeDifference.minute!)) minutes ago"    // more than 1 minute
            }
        }
        else
        {
            return "Just now"
        }
    }
    

}
