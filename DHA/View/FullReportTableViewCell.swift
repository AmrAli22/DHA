//
//  FullReportTableViewCell.swift
//  DHA
//
//  Created by Sayed Abdo on 12/12/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class FullReportTableViewCell: UITableViewCell {
    
    
    /////////Outlets
    
    @IBOutlet weak var TxtFieldRepoName: UITextField!
    @IBOutlet weak var TxtFieldDate: UITextField!
    @IBOutlet weak var TxtFieldRepoLoc: UITextField!
    @IBOutlet weak var TxtFieldCat: UITextField!
    ////
    @IBOutlet weak var TxtFieldQ1Answer: UITextView!
    @IBOutlet weak var TxtFieldQ2Answer: UITextView!
    @IBOutlet weak var TxtFieldRiskValue: UITextField!
    @IBOutlet weak var TxtFieldQ4Answer: UITextView!
    @IBOutlet weak var TxtFieldQ5Answer: UITextView!
    

    func ConfigureCell (name : String , Date : String , Location : String , Catogry : String , Q1 : String , Q2 : String , RiskValue : String , Q4 : String , Q5 : String)
    {
        TxtFieldCat.text = Catogry
        TxtFieldDate.text = Date
        TxtFieldRepoLoc.text = Location
        TxtFieldRepoName.text = name
        
        TxtFieldQ1Answer.text = Q1
        TxtFieldQ2Answer.text = Q2
        TxtFieldRiskValue.text = RiskValue
        TxtFieldQ4Answer.text = Q4
        TxtFieldQ5Answer.text = Q5
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
