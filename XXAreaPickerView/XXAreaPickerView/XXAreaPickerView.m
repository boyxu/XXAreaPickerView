//
//  XXAreaPickerView.m
//  DuduCard
//
//  Created by 徐英杰 on 16/6/21.
//  Copyright © 2016年 Yingjie Xu. All rights reserved.
//

#import "XXAreaPickerView.h"

NSArray* XX_AreaData() {
    static NSArray *singleData;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *areaPath = [[NSBundle mainBundle] pathForResource:@"xx_area" ofType:@"plist"];
        NSArray *data = [NSArray arrayWithContentsOfFile:areaPath];
        singleData = data;
    });
    return singleData;
}


@interface XXAreaPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *areaData;

@end

@implementation XXAreaPickerView

#pragma mark - Methods
- (NSString *)province {
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    NSString *string = [self pickerView:self.pickerView titleForRow:row forComponent:0];
    return string;
}

- (NSString *)city {
    NSInteger row = [self.pickerView selectedRowInComponent:1];
    NSString *string = [self pickerView:self.pickerView titleForRow:row forComponent:1];
    return string;
}

- (NSString *)district {
    NSInteger row = [self.pickerView selectedRowInComponent:2];
    NSString *string = [self pickerView:self.pickerView titleForRow:row forComponent:2];
    return string;
}

#pragma mark - Init
+ (instancetype)areaPickerView {
    XXAreaPickerView *instance = [[XXAreaPickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 216)];
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.areaData = XX_AreaData();
        [self commitInit];
    }
    return self;
}

- (void)commitInit {
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:pickerView];
    self.pickerView = pickerView;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:{
            return [self.areaData count];
        }
            break;
        case 1:{
            NSInteger selectedState = [pickerView selectedRowInComponent:0];
            if (selectedState == -1) {
                return 0;
            }
            NSDictionary *stateDic = self.areaData[selectedState];
            NSArray *cities = stateDic[@"cities"];
            return [cities count];
        }
            break;
        case 2:{
            NSInteger selectedState = [pickerView selectedRowInComponent:0];
            NSInteger selectedCity = [pickerView selectedRowInComponent:1];
            if (selectedState == -1 || selectedCity == -1) {
                return 0;
            }
            NSDictionary *stateDic = self.areaData[selectedState];
            NSArray *cities = stateDic[@"cities"];
            NSDictionary *cityDic = cities[selectedCity];
            NSArray *areas = cityDic[@"areas"];
            return [areas count];
        }
            break;
        default:
            break;
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSInteger selectedState = [pickerView selectedRowInComponent:0];
    NSInteger selectedCity = [pickerView selectedRowInComponent:1];
    switch (component) {
        case 0: {
            NSString *state = [[self.areaData objectAtIndex:row] objectForKey:@"state"];
            return state;
        }
            break;
        case 1: {
            if (selectedState == -1) {
                return nil;
            }
            NSDictionary *stateDic = self.areaData[selectedState];
            NSArray *cities = stateDic[@"cities"];
            return [cities[row] objectForKey:@"city"];
        }
            break;
        case 2: {
            if (selectedState == -1 || selectedCity == -1) {
                return nil;
            }
            NSDictionary *stateDic = self.areaData[selectedState];
            NSArray *cities = stateDic[@"cities"];
            NSDictionary *cityDic = cities[selectedCity];
            NSArray *areas = cityDic[@"areas"];
            if ([areas count] == 0) {
                return nil;
            }
            return areas[row];
        }
            break;
        default:
            return nil;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0: {
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
        case 1:{
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
        case 2:{
            
        }
            break;
        default:
            break;
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
