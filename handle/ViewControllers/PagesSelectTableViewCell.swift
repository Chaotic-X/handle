//
//  PagesSelectTableViewCell.swift
//  handle
//
//  Created by Ben Huggins on 5/6/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import UIKit

class PagesSelectTableViewCell: UITableViewCell {

    var delegate: PagesSelectTableViewCellDelegate?
    
    @IBOutlet weak var pageNameLabel: UILabel!
    
    @IBOutlet weak var pagesToggle: UISwitch!

    var pageSelectCellLandingPad: String? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pagesToggle.isOn = false
        // Initialization code
    }
   
    @IBAction func pagesToggleSelected(_ sender: UISwitch) {
            delegate?.pageToggleSelected(self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    @IBAction func pagesToggleSelected(_ sender: Any) {
        if ((sender as AnyObject).isOn == true) {
            
            delegate?.pageToggleSelected(self)
            
        } else {
           
            
            
        }
        
    }

    func updateViews() {
        guard let pageNames = pageSelectCellLandingPad else {print("💋");return}
        pageNameLabel.text = pageNames
    }
}
  
protocol PagesSelectTableViewCellDelegate: class {
    func pageToggleSelected(_ sender: PagesSelectTableViewCell)
    
}
