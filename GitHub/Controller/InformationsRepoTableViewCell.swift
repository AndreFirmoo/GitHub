//
//  InformationsRepoTableViewCell.swift
//  GitHub
//
//  Created by Andre Jardim Firmo on 28/08/19.
//  Copyright © 2019 Andre Jardim Firmo. All rights reserved.
//

import UIKit

class InformationsRepoTableViewCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbLanguage: UILabel!
    @IBOutlet weak var lbStar: UILabel!
    @IBOutlet weak var lbFork: UILabel!
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var ivStar: UIImageView!
    @IBOutlet weak var ivFork: UIImageView!
    @IBOutlet weak var lbDescriptions: UILabel!
    @IBOutlet weak var lbLogin: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func prepare(with repo: Item){
        lbLogin.text = repo.owner.login
        lbDescriptions.text = repo.description
        lbLanguage.text = repo.language
        lbName.text = repo.name
        lbStar.text = String(repo.stargazers_count)
        lbFork.text = String(repo.forks)
        let url = URL(string: repo.owner.avatar_url)
        let data = try? Data(contentsOf: url!)
        ivAvatar.image = UIImage(data: data!)
        ivFork.image = UIImage(named: "fork")
        ivStar.image = UIImage(named: "star")
        ivAvatar.layer.cornerRadius = ivAvatar.frame.size.width/2
        ivAvatar.clipsToBounds = true
    }
}
