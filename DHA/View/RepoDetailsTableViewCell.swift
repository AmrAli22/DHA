//
//  RepoDetailsTableViewCell.swift
//  DHA
//
//  Created by Sayed Abdo on 12/11/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class RepoDetailsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var TxtFieldRepoName: UITextField!
    @IBOutlet weak var TxtFieldRepoDate: UITextField!
    @IBOutlet weak var TxtFieldRepoTime: UITextField!
    @IBOutlet weak var TxtFieldRepoLocation: UITextField!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func ConfigureCell(_RepoName : String , _RepoDate : String , _RepoTime : String , _RepoLoc : String)
    {
        TxtFieldRepoDate.text = _RepoDate
        TxtFieldRepoTime.text = _RepoTime
        TxtFieldRepoName.text = _RepoName
        TxtFieldRepoLocation.text = _RepoLoc
        
    }
}
