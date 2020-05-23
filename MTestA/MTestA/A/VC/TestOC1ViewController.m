//
//  TestOC1ViewController.m
//  TestA
//
//  Created by 董雪娇 on 2020/3/6.
//  Copyright © 2020 董雪娇. All rights reserved.
//
#import "TestOC1ViewController.h"
#import <MBasis/FWToolKit.h>
#import <MBasis/NSObject+CTMediator_TestA_OC.h>

@interface TestOC1ViewController ()
/////
@end

@implementation TestOC1ViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //验证回调是否正确
    if (self.testCompleteHandler) {
        self.testCompleteHandler(@"TestOC1ViewController-block");
    }
    self.view.backgroundColor=[UIColor blueColor];
    
    //[BasisTool toolMethods:@"TestC"];//TestC没有集成BasisTool
    self.navigationItem.title = NSStringFromClass(self.class);
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"oc->oc->oc" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 200, 50);
    [btn addTarget:self action:@selector(btn_Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"oc->oc->swift" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    btn1.frame = CGRectMake(100, 200, 200, 50);
    [btn1 addTarget:self action:@selector(btn_Action1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"oc->swift->oc" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor redColor];
    btn2.frame = CGRectMake(100, 300, 200, 50);
    [btn2 addTarget:self action:@selector(btn_Action2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"oc->swift->swift" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor redColor];
    btn3.frame = CGRectMake(100, 400, 200, 50);
    [btn3 addTarget:self action:@selector(btn_Action3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
}

- (void)btn_Action{
    UIViewController *testOC2 = [[CTMediator sharedInstance] ModuleA_showTargetOC_ActionOC:^(NSString * _Nonnull result) {
        NSLog(@"result:%@",result);
        NSString * msg = [NSString stringWithFormat:@"ModuleA_showTargetOC_ActionOC:%@",result];
        [FWToolKit showNoticeText:msg];

    }];
    
    if (testOC2) {
        [self.navigationController pushViewController:testOC2 animated:true];
    }
}

- (void)btn_Action1{
    UIViewController *testSwift2 = [[CTMediator sharedInstance] ModuleA_showTargetOC_ActionSwift:^(NSString * _Nonnull result) {
        NSString * msg = [NSString stringWithFormat:@"ModuleA_showTargetOC_ActionSwift:%@",result];
        [FWToolKit showNoticeText:msg];
    }];
    
    if (testSwift2) {
        [self.navigationController pushViewController:testSwift2 animated:true];
    }
}

- (void)btn_Action2{
    UIViewController *OCTest1 = [[CTMediator sharedInstance] ModuleA_showTargetSwift_ActionOC:^(NSString * _Nonnull result) {
        NSString * msg = [NSString stringWithFormat:@"ModuleA_showTargetSwift_ActionOC:%@",result];
        [FWToolKit showNoticeText:msg];
    }];
    
    if (OCTest1) {
        [self.navigationController pushViewController:OCTest1 animated:true];
    }
}

- (void)btn_Action3{
    UIViewController *SwiftTest1 = [[CTMediator sharedInstance] ModuleA_showTargetSwift_ActionSwift:^(NSString * _Nonnull result) {
        NSString * msg = [NSString stringWithFormat:@"ModuleA_showTargetSwift_ActionSwift:%@",result];
        [FWToolKit showNoticeText:msg];
    }];
    
    if (SwiftTest1) {
        [self.navigationController pushViewController:SwiftTest1 animated:true];
    }
}


@end
