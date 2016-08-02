//
//  ViewController.swift
//  XXAreaPickerView
//
//  Created by 徐英杰 on 16/6/22.
//  Copyright © 2016年 Yingjie Xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let areaPickerView = XXAreaPickerView.areaPickerView()
        
        self.view.addSubview(areaPickerView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

