//
//  ViewController.m
//  DigitalPasscode-master
//
//  Created by 黄海燕 on 17/1/5.
//  Copyright © 2017年 huanghy. All rights reserved.
//

#import "ViewController.h"
#import "DigitalPasscodeView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    DigitalPasscodeView *digitalView = [[DigitalPasscodeView alloc]initWithFrame:CGRectMake(30, 100, 332, 60)];
    digitalView.passwordDidChangeBlock = ^(NSString *password){
        NSLog(@"password:%@",password);
    };
    digitalView.center = CGPointMake(self.view.center.x, 100);
    [self.view addSubview:digitalView];
    
}


@end
