//
//  DatePickerTextField.h
//  Liberty
//
//  Created by OSX on 22/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickerTextFieldDelegate;


@protocol DatePickerTextFieldDelegate <NSObject>
@optional
- (void)datePickerTextFieldClickOnDoneButton:(UITextField *)textField;
- (void)datePickerTextFieldValueChanged:(NSString *)date  withTextField:(UITextField*)fields ;

@end

@interface DatePickerTextField : UITextField


@property(weak,nonatomic) IBOutlet id<DatePickerTextFieldDelegate>delegateDP;
@property (nonatomic) IBInspectable NSString * rightText;
@property (nonatomic) IBInspectable BOOL boolmaxDate;
@property (nonatomic) IBInspectable BOOL boolminDate;
@property (nonatomic) IBInspectable BOOL boolNotToday;

@end
