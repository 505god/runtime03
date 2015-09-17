//
//  ViewController.m
//  runtime03
//
//  Created by 邱成西 on 15/9/17.
//  Copyright (c) 2015年 邱成西. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

static const char associatedkey;
static const char associatedButtonkey;

@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendAlert:(id)sender
{
    
    NSString *message = @"我知道你是按钮了";
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"我要传值·" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alert.delegate = self;
    [alert show];
    //#import <objc/runtime.h>头文件
    
    //objc_setAssociatedObject 需要四个参数：源对象，关键字，关联的对象和一个关联策略。
    
    //1 源对象alert
    //2 关键字 唯一静态变量key associatedkey
    //3 关联的对象 sender
    //4 关键策略  OBJC_ASSOCIATION_RETAIN_NONATOMIC
    
    
    objc_setAssociatedObject(alert, &associatedkey, message, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(alert, &associatedButtonkey, sender, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    //通过 objc_getAssociatedObject 获取关联对象
    NSString  *messageString = objc_getAssociatedObject(alertView, &associatedkey);
    
    
    UIButton *sender =  objc_getAssociatedObject(alertView, &associatedButtonkey);
    
    _labebutton.text = [[sender titleLabel] text];
    _ThisLabel.text = messageString;
    
    
    // 使用函数objc_removeAssociatedObjects可以断开所有关联。通常情况下不建议使用这个函数，因为他会断开所有关联。只有在需要把对象恢复到“原始状态”的时候才会使用这个函数。
}

@end
