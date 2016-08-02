//
//  XXAreaPickerView.h
//  DuduCard
//
//  Created by 徐英杰 on 16/6/21.
//  Copyright © 2016年 Yingjie Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXAreaPickerView : UIControl 

+ (instancetype)areaPickerView;

@property (nonatomic, readonly) NSString *province; //省
@property (nonatomic, readonly) NSString *city;     //市
@property (nonatomic, readonly) NSString *district; //区&县

@end

