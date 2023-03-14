//
//  DetailsViewController.swift
//  GitHub
//
//  Created by Andre Jardim Firmo on 30/08/19.
//  Copyright © 2019 Andre Jardim Firmo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableview: UITableView!
    
    var login = ""
    var name = ""
    var informations : Items!
    var pulls = [Pulls]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableFooterView = UIView()
        loadPulls(login: login, name: name) { (info) in
            self.pulls = info
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pulls.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailsTableViewCell
        let getInfos = pulls[indexPath.row]
        cell.preparar(with: getInfos)
        return cell
    }
    
}
