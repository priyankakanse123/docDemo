//
//  ProfileTableViewCell.swift
//  Docplexus_demo
//
//  Created by Priyanka Kanse on 15/03/18.
//  Copyright © 2018 Priyanka Kanse. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var autherName: UILabel!
    @IBOutlet weak var descriptnLable: UILabel!
    @IBOutlet weak var titleStatmntLabl: UILabel!
    @IBOutlet weak var diseaseInfoLbl: UILabel!
    @IBOutlet weak var queryPostedTimeLbl: UILabel!
    @IBOutlet weak var queryImgView: UIImageView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var viewButtn: UIButton!
    @IBOutlet weak var voteButtn: UIButton!
    @IBOutlet weak var commentButtn: UIButton!
    @IBOutlet weak var queryImgAspectRatio: NSLayoutConstraint!
    @IBOutlet weak var postImgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
