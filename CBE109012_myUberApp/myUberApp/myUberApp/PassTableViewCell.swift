//
//  PassTableViewCell.swift
//  myUberApp
//
//  Created by students on 2022/5/27.
//

import UIKit

class PassTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var detailLab: UILabel!
    
    func configureCell(profileImage: UIImage, email: String, detail: String) {
        self.profileImage.image = profileImage
        self.userEmail.text = email
        self.detailLab.text = detail
        
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
