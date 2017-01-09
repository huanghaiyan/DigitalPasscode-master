//
//  DigitalPasscodeView.m
//  DigitalPasscode-master
//
//  Created by 黄海燕 on 17/1/5.
//  Copyright © 2017年 huanghy. All rights reserved.
//

#import "DigitalPasscodeView.h"

#define DIGIT_COUNT      5
#define DIGIT_WIDTH     60
#define DIGIT_HEIGHT    60
#define DIGIT_SPACING    8

#define MARKER_X        15
#define MARKER_Y        15

@interface DigitalPasscodeView ()<UITextFieldDelegate>
{
    UITextField *passcodeTextField;
    UIImageView *digitImageViews[6];
}
- (void)passcodeChanged:(id)sender;

@end

@implementation DigitalPasscodeView

#pragma mark - initialization
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.autoHideKeyboard = YES;
        [self createView];
    }
    return self;
}

- (void)createView
{
    //底部view
    CGFloat panelWidth = DIGIT_WIDTH*DIGIT_COUNT+DIGIT_SPACING*(DIGIT_COUNT-1);
    UIView *digitPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, panelWidth, DIGIT_HEIGHT)];
    //digitPanel.frame = CGRectOffset(digitPanel.frame, (self.bounds.size.width-digitPanel.bounds.size.width)/2, 74);
    digitPanel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
   // digitPanel.backgroundColor = [UIColor blueColor];
    [self addSubview:digitPanel];
    //框框的背景图，和遮盖图
    UIImage *backgroundImage = [UIImage imageNamed:@"settings-Rechthoek"];
    UIImage *markerImage = [UIImage imageNamed:@"settings-Groep"];
    CGFloat xLeft = 0;
    for (int i=0;i<DIGIT_COUNT;i++) {
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
        backgroundImageView.frame = CGRectOffset(backgroundImageView.frame, xLeft, 0);
        [digitPanel addSubview:backgroundImageView];
        digitImageViews[i] = [[UIImageView alloc] initWithImage:markerImage];
        digitImageViews[i].autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        digitImageViews[i].frame = CGRectOffset(digitImageViews[i].frame, backgroundImageView.frame.origin.x+MARKER_X, MARKER_Y);
        digitImageViews[i].hidden = YES;
        [digitPanel addSubview:digitImageViews[i]];
        xLeft += DIGIT_SPACING + backgroundImage.size.width;
    }
    passcodeTextField = [[UITextField alloc] initWithFrame:digitPanel.frame];
    passcodeTextField.hidden = YES;
    //pas1scodeTextField.backgroundColor = [UIColor redColor];
    passcodeTextField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    passcodeTextField.borderStyle = UITextBorderStyleNone;
    //passcodeTextField.secureTextEntry = YES;//设置成密码形式点击删除键时，会一次性把内容删除完
    passcodeTextField.delegate = self;
    passcodeTextField.textColor = [UIColor colorWithRed:0.23 green:0.33 blue:0.52 alpha:1.0];
    passcodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [passcodeTextField addTarget:self action:@selector(passcodeChanged:) forControlEvents:UIControlEventEditingChanged];
    [digitPanel addSubview:passcodeTextField];

}

- (void)passcodeChanged:(id)sender
{
    NSString *text = passcodeTextField.text;
    if ([text length] > DIGIT_COUNT) {
        return;
    }
    for (int i=0;i<DIGIT_COUNT;i++) {
        digitImageViews[i].hidden = i >= [text length];
    }
    if ([text length] == DIGIT_COUNT) {
        if (self.autoHideKeyboard) {
            !self.passwordDidChangeBlock ? : self.passwordDidChangeBlock(text);
            [self hideKeyboard];//隐藏键盘
        }
    }
    NSLog(@"%@",text);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //string就是此时输入的那个字符，textfield就是此时正在输入的那个输入框，返回YES就是可以改变输入框的值，NO相反
    NSLog(@"textField:%@",textField.text);
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *password = toBeString;
    
    if (password.length > DIGIT_COUNT) {
        
        return NO;
    }
    
    return YES;
}

#pragma mark - publick method
- (void)clearPassword {
    passcodeTextField.text = nil;
    [self passcodeChanged:passcodeTextField];
}

- (void)showKeyboard {
    [passcodeTextField becomeFirstResponder];
}

- (void)hideKeyboard {
    [passcodeTextField resignFirstResponder];
}

//touch时，使passcodeTextField成为第一响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self showKeyboard];
}

@end
