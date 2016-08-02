//
//  XXAreaPickerView.swift
//  XXAreaPickerView
//
//  Created by 徐英杰 on 16/6/22.
//  Copyright © 2016年 Yingjie Xu. All rights reserved.
//

import UIKit

class XXAreaPickerView: UIControl  {
    // MARK: property
    lazy var areaData: NSArray? = {
        let path = NSBundle.mainBundle().pathForResource("xx_area", ofType: "plist")!
        return NSArray(contentsOfFile: path)
    }()
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView(frame: self.bounds)
        picker.delegate = self;
        picker.dataSource = self;
        picker.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        return picker
    }()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.pickerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func areaPickerView() -> XXAreaPickerView {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 216)
        let pickerView = XXAreaPickerView(frame: frame)
        return pickerView;
    }
}

extension XXAreaPickerView {
    // MARK: method
    var province: String? {
        get {
            let row = pickerView.selectedRowInComponent(0)
            let string = self.pickerView(pickerView, titleForRow: row, forComponent: 0)
            return string
        }
    }
    var city: String? {
        get {
            let row = pickerView.selectedRowInComponent(1)
            let string = self.pickerView(pickerView, titleForRow: row, forComponent: 1)
            return string
        }
    }
    var district: String? {
        get {
            let row = pickerView.selectedRowInComponent(2)
            let string = self.pickerView(pickerView, titleForRow: row, forComponent: 2)
            return string
        }
    }
}

extension XXAreaPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let data = areaData else {
            return 0
        }
        
        switch component {
        case 0:
            return data.count
        case 1:
            let selectedState = pickerView.selectedRowInComponent(0)
            if selectedState == -1 {
                return 0
            }
            let stateDic = data[selectedState]
            let cities = stateDic["cities"] as! NSArray
            return cities.count
        case 2:
            let selectedState = pickerView.selectedRowInComponent(0)
            let selectedCity = pickerView.selectedRowInComponent(1)
            if (selectedState == -1 || selectedCity == -1) {
                return 0;
            }
            let stateDic = data[selectedState]
            guard let cities = stateDic["cities"] else {
                return 0
            }
            let cityDic = cities![selectedCity]
            let areas = cityDic?["areas"]
            return areas??.count ?? 0
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let selectedState = pickerView.selectedRowInComponent(0)
        let selectedCity = pickerView.selectedRowInComponent(1)
        
        switch component {
        case 0:
            let cities = areaData?[row]
            let state = cities?["state"] as! String
            return nil
        case 1:
            return nil
        case 2:
            
            return nil
        default:
            return nil
        }
        
        
        
        
        return nil
    }
    
    
}

