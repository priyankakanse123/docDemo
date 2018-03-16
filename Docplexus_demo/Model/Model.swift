//
//  Model.swift
//  Docplexus_demo
//
//  Created by Priyanka Kanse on 16/03/18.
//  Copyright © 2018 Priyanka Kanse. All rights reserved.
//

import UIKit

//post model
class Model: NSObject {
    
    var title : String?
    var uuid : String?
    var postType : String?
    var typeName : String?
    var featuredAttachmentUrl : String?
    var featuredAttachmentWidth : Int?
    var featuredAttachmentHeigth : Int?
    var embedURL : String?
    var creationDate : String?
    var answerCount : Int?
    var viewCount : Int?
    var voteCount : Int?
    var user : UserModel?
    var therapeutics = [TherapeuticsModel]()
    var attachments = [AttachmentsModel]()
    var infocenter : String?
    var viewed : Bool?
    var voted : Bool?
    var shortBodyText : String?

    
    init(jsonDict:NSDictionary)
    {
        if(jsonDict["title"] is String)
        {
            self.title = jsonDict["title"] as? String
        }
        if(jsonDict["uuid"] is String)
        {
            self.uuid = jsonDict["uuid"] as? String
        }
        if(jsonDict["postType"] is String)
        {
            self.postType = jsonDict["postType"] as? String
        }
        if(jsonDict["typeName"] is String)
        {
            self.typeName = jsonDict["typeName"] as? String
        }
        if(jsonDict["featuredAttachmentUrl"] is String)
        {
            self.featuredAttachmentUrl = jsonDict["featuredAttachmentUrl"] as? String
        }
        if(jsonDict["featuredAttachmentWidth"] is Int)
        {
            self.featuredAttachmentWidth = jsonDict["featuredAttachmentWidth"] as? Int
        }
        if(jsonDict["featuredAttachmentHeigth"] is Int)
        {
            self.featuredAttachmentHeigth = jsonDict["featuredAttachmentHeigth"] as? Int
        }

        if(jsonDict["embedURL"] is String)
        {
            self.embedURL = jsonDict["embedURL"] as? String
        }
        if(jsonDict["creationDate"] is String)
        {
            self.creationDate = jsonDict["creationDate"] as? String
        }
        if(jsonDict["answerCount"] is Int)
        {
            self.answerCount = jsonDict["answerCount"] as? Int
        }
        if(jsonDict["viewCount"] is Int)
        {
            self.viewCount = jsonDict["viewCount"] as? Int
        }
        if(jsonDict["voteCount"] is Int)
        {
            self.voteCount = jsonDict["voteCount"] as? Int
        }
        if(jsonDict["user"] is NSDictionary)
        {
            self.user = UserModel(jsonDict: jsonDict["user"] as! NSDictionary)
        }
        if(jsonDict["infocenter"] is String)
        {
            self.infocenter = jsonDict["infocenter"] as? String
        }
        if(jsonDict["viewed"] is Bool)
        {
            self.viewed = jsonDict["viewed"] as? Bool
        }
        if(jsonDict["voted"] is Bool)
        {
            self.voted = jsonDict["voted"] as? Bool
        }
        
        //array values therapeutics
        if(jsonDict["therapeutics"] is NSArray)
        {
            for item in (jsonDict["therapeutics"] as! NSArray)
            {
                if(item is NSDictionary)
                {
                    let itemDict = item as! NSDictionary
                    let therapeuticsModelObj = TherapeuticsModel(jsonDict: itemDict)
                    self.therapeutics.append(therapeuticsModelObj)
                }
            }
            self.voted = jsonDict["voted"] as? Bool
        }
        
        //array values
        if(jsonDict["attachments"] is NSArray)
        {
            for item in (jsonDict["attachments"] as! NSArray)
            {
                if(item is NSDictionary)
                {
                    let itemDict = item as! NSDictionary
                    let attachmentsModelObj = AttachmentsModel(jsonDict: itemDict)
                    self.attachments.append(attachmentsModelObj)
                }
            }
            self.voted = jsonDict["voted"] as? Bool
        }
        
        if(jsonDict["shortBodyText"] is String)
        {
            self.shortBodyText = jsonDict["shortBodyText"] as? String
        }


    }
}

class UserModel
{
    var thumbnailUrl : String?
    var firstName : String?
    var lastName : String?
    var authorName : String?
    var uuid : String?
    var designation : String?
    var joinedSince : String?
    var followed : Bool?
    var editor : Bool?
    var loggedIn : Bool?
    var shortBodyText : String?
    var deleted : Bool?
    
    init(jsonDict:NSDictionary)
    {
        if(jsonDict["thumbnailUrl"] is String)
        {
            self.thumbnailUrl = jsonDict["thumbnailUrl"] as? String
        }
        if(jsonDict["uuid"] is String)
        {
            self.uuid = jsonDict["uuid"] as? String
        }
        if(jsonDict["firstName"] is String)
        {
            self.firstName = jsonDict["firstName"] as? String
        }
        if(jsonDict["lastName"] is String)
        {
            self.lastName = jsonDict["lastName"] as? String
        }
        if(jsonDict["authorName"] is String)
        {
            self.authorName = jsonDict["authorName"] as? String
        }
        if(jsonDict["designation"] is String)
        {
            self.designation = jsonDict["designation"] as? String
        }
        if(jsonDict["joinedSince"] is String)
        {
            self.joinedSince = jsonDict["joinedSince"] as? String
        }
        if(jsonDict["followed"] is Bool)
        {
            self.followed = jsonDict["followed"] as? Bool
        }
        if(jsonDict["editor"] is Bool)
        {
            self.editor = jsonDict["editor"] as? Bool
        }
        if(jsonDict["loggedIn"] is Bool)
        {
            self.loggedIn = jsonDict["loggedIn"] as? Bool
        }
        if(jsonDict["shortBodyText"] is String)
        {
            self.shortBodyText = jsonDict["shortBodyText"] as? String
        }
        if(jsonDict["deleted"] is Bool)
        {
            self.deleted = jsonDict["deleted"] as? Bool
        }
    }

}
// topic details model
class TherapeuticsModel
{
    var uuid : String?
    var name : String?
    init(jsonDict:NSDictionary)
    {
        if(jsonDict["name"] is String)
        {
            self.name = jsonDict["name"] as? String
        }
        if(jsonDict["uuid"] is String)
        {
            self.uuid = jsonDict["uuid"] as? String
        }
    }

}

//attachment model
class AttachmentsModel
{
    var url : String?
    var uuid : String?
    var name : String?
    var width : Int?
    var height : Int?
    init(jsonDict:NSDictionary)
    {
        if(jsonDict["name"] is String)
        {
            self.name = jsonDict["name"] as? String
        }
        if(jsonDict["uuid"] is String)
        {
            self.uuid = jsonDict["uuid"] as? String
        }
        if(jsonDict["url"] is String)
        {
            self.url = jsonDict["url"] as? String
        }
        if(jsonDict["width"] is Int)
        {
            self.width = jsonDict["width"] as? Int
        }
        if(jsonDict["height"] is Int)
        {
            self.height = jsonDict["height"] as? Int
        }

    }

}


