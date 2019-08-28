//
//  ViewController.swift
//  GitHub
//
//  Created by Andre Jardim Firmo on 27/08/19.
//  Copyright © 2019 Andre Jardim Firmo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
   
    
    private let dataSource = ["C#","Java","Swift","Kotlin","Javascript"]

    @IBOutlet weak var pvLanguage: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pvLanguage.delegate = self
        pvLanguage.dataSource = self
        // Do any additional setup after loading the view.
    }
    @IBAction func BtnSelectedRow(_ sender: Any) {
        let selectedRow = self.pvLanguage.selectedRow(inComponent: 0)
        let value = dataSource[selectedRow]
        print(selectedRow)
        print(value)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
}

