//
//  ViewController.swift
//  GitHub
//
//  Created by Andre Jardim Firmo on 27/08/19.
//  Copyright © 2019 Andre Jardim Firmo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
   
    
    private let dataSource = ["C","Java","Swift","Kotlin","Javascript","Typescript"]

    @IBOutlet weak var pvLanguage: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pvLanguage.delegate = self
        pvLanguage.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    @IBAction func BtnSelectedRow(_ sender: Any) {
        //performSegue(withIdentifier: "Cell", sender: self)
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Cell"{
            let listRepo = segue.destination as! InformationViewController
            let selectedRow = self.pvLanguage.selectedRow(inComponent: 0)
            let value = dataSource[selectedRow]
            listRepo.languages = value
           
        }
    }
}

