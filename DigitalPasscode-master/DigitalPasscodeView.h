//
//  DigitalPasscodeView.h
//  DigitalPasscode-master
//
//  Created by 黄海燕 on 17/1/5.
//  Copyright © 2017年 huanghy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DigitalPasscodeView : UIView

/**
 the password is user inputed
 */
@property (nonatomic, copy) void(^passwordDidChangeBlock)(NSString *password);

/**
 auto hide the keyboard when input password was completed, default is YES
 */
@property (nonatomic, assign) BOOL autoHideKeyboard;

/**
 clear all password
 */
- (void)clearPassword;

/**
 show keyboard
 */
- (void)showKeyboard;
/**
 hide keyboard
 */
- (void)hideKeyboard;


@end
