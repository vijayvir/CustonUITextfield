//
//  DatePickerTextField.m
//  Liberty
//
//  Created by OSX on 22/04/16.
//  Copyright © 2016 Avneet. All rights reserved.
//

#import "DatePickerTextField.h"

#define datePickerToPass @"yyyy-MM-dd"
#define dateformatToShow @"dd-MM-yyyy"





@implementation DatePickerTextField
{
    UIDatePicker *datePicker;
    
}
@synthesize delegateDP,boolmaxDate , boolminDate , rightText , boolNotToday;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    self.font = [UIFont fontWithName:@"OpenSans" size:self.font.pointSize];
    
    [super awakeFromNib];


    if (boolmaxDate)
    {
        if(boolNotToday)
        {
              datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow: -(60.0f*60.0f*24.0f)];
       
        }
        
        else
        {
                datePicker.maximumDate = [NSDate date];
        }
        
    }
    
    if (boolminDate)
    {
       datePicker.minimumDate = [NSDate date];
        
        NSDate *today = [NSDate date]; // get the current date
        NSCalendar* cal = [NSCalendar currentCalendar]; // get current calender
        NSDateComponents* dateOnlyToday = [cal components:( NSCalendarUnitYear | NSCalendarUnitMonth  |  NSCalendarUnitDay ) fromDate:today];
        [dateOnlyToday setYear:([dateOnlyToday year] -1)];
        
        datePicker.minimumDate =[cal dateFromComponents:dateOnlyToday];
    }
    
    
    

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        
        UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
        
        [keyboardDoneButtonView sizeToFit];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStyleDone target:self
                                                                      action:@selector(numberPaddoneClicked:)];
        UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:space,doneButton, nil]];
        
        
        
        self.inputAccessoryView = keyboardDoneButtonView;
        
        datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
      
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //[dateFormatter setDateFormat:dateformatVJ];
    
        
       //datePicker.date = [dateFormatter dateFromString:self.text];
        datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        datePicker.tag = 6;
        self.inputView = datePicker;
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
       
    }
    
    
    
    return self;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateformatToShow];
    
    
    if (self.text.length>0)
    {
        if ( ![dateFormatter dateFromString:self.text])
        {
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:datePickerToPass];
             datePicker.date = [dateFormatter2 dateFromString:self.text];
            return;
            
        }
        
           datePicker.date = [dateFormatter dateFromString:self.text];
    }
 
    
}




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
        
        [keyboardDoneButtonView sizeToFit];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStyleDone target:self
                                                                      action:@selector(numberPaddoneClicked:)];
        UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:space,doneButton, nil]];
        
        
        
        self.inputAccessoryView = keyboardDoneButtonView;
        
        datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //[dateFormatter setDateFormat:dateformatVJ];
        
        
      //  datePicker.date = [NSDate date];
        datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        datePicker.tag = 6;
        self.inputView = datePicker;
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
    }
    return self;
}
-(void)datePickerValueChanged:(UIDatePicker*)datePickerr
{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateformatToShow];
    NSString *strDate = [dateFormatter stringFromDate:datePickerr.date];
    
    self.text = strDate;
    
    if (delegateDP)
    {
        if ([delegateDP respondsToSelector:@selector(datePickerTextFieldValueChanged:withTextField:)])
        {
            NSDateFormatter *send = [[NSDateFormatter alloc] init];
            [send setDateFormat:datePickerToPass];
            NSString *sendDate = [send stringFromDate:datePickerr.date];
            
            
            [delegateDP datePickerTextFieldValueChanged:sendDate withTextField:self];
            

        }
        
      
    }
  
    
}
-(void)numberPaddoneClicked:(id)sender
{
    [self datePickerValueChanged:datePicker];
    [self resignFirstResponder];
    if (delegateDP)
    {
         if ([delegateDP respondsToSelector:@selector(datePickerTextFieldClickOnDoneButton:)])
         {
           [delegateDP datePickerTextFieldClickOnDoneButton:self];
         }

    }
    
    
}

@end
