//
//  DetailsTableViewCell.swift
//  GitHub
//
//  Created by Andre Jardim Firmo on 30/08/19.
//  Copyright © 2019 Andre Jardim Firmo. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var lbLogin: UILabel!
    @IBOutlet weak var ivAvatarUrl: UIImageView!
    @IBOutlet weak var lbBody: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func preparar(with pulls: Pulls){
        lbLogin.text = pulls.head.repo.owner.login
        lbBody.text = pulls.body
        lbTitle.text = pulls.title
        let url = URL(string: pulls.head.repo.owner.avatar_url)
        let data = try? Data(contentsOf: url!)
        ivAvatarUrl.image = UIImage(data: data!)
        
        ivAvatarUrl.layer.cornerRadius = ivAvatarUrl.frame.size.width/2
        ivAvatarUrl.clipsToBounds = true
    }
   
    
}
