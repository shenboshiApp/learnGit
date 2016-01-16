//
//  GSPasswordView.m
//  GreenStoneUser
//
//  Created by greenstone on 15/5/27.
//  Copyright (c) 2015年 greenStone. All rights reserved.
//

#import "GSPasswordView.h"

@implementation GSPasswordView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatPasswordView];
        [self popPasswordView];
    }
    return self;
}
-(void)creatPasswordView{

    _passwordField = [[UITextField alloc]initWithFrame:CGRectMake(40, 30, 0, 40)];
    _passwordField.backgroundColor = [UIColor redColor];
    _passwordField.textAlignment = NSTextAlignmentCenter;
    _passwordField.delegate = self;
    [self addSubview:_passwordField];
    _passwordField.keyboardType = UIKeyboardTypeNumberPad;
}
- (void)popPasswordView{
    _passwordView = [[UIImageView alloc]init];
    _passwordView.frame = CGRectMake(KOriginX(40), KNOriginY(190), KWidth(240), KNHeight(145));
    [self addSubview:_passwordView];
    _passwordView.backgroundColor = [UIColor whiteColor];
    _passwordView.image = [UIImage imageNamed:@"image_password"];
    _passwordView.layer.cornerRadius = 5;
    _passwordView.userInteractionEnabled = YES;
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, KNOriginY(5), _passwordView.frame.size.width, KNHeight(30))];
    titleLabel.text = @"请输入绿石支付密码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = RGB(150.0, 150.0, 150.0, 1);
    [_passwordView addSubview:titleLabel];
    
    for (int index = 0; index < 6; index ++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(KOriginX(28.5)+index *KOriginX(35), KNOriginY(55), KNHeight(8), KNHeight(8))];
        label.tag = 100+index;
        label.layer.cornerRadius = KNHeight(8)/2.0;
        label.layer.masksToBounds = YES;
        label.hidden = YES;
        label.backgroundColor = [UIColor blackColor];
        [_passwordView addSubview:label];
    }
    for (int btnIndex = 0; btnIndex<2; btnIndex++) {
        NSArray *titleArray = @[@"取消",@"确定"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(KOriginX(15)+btnIndex*KOriginX(110), KNOriginY(90), KWidth(100), KNHeight(32));
        [_passwordView addSubview:button];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.backgroundColor = [UIColor whiteColor];
        button.tag = 200 + btnIndex;
        [button setTitle:titleArray[btnIndex] forState:UIControlStateNormal];
        [button setTitleColor:RGB(50.0, 50.0, 50.0, 1) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        if (button.tag == 200) {
            [button addTarget:self action:@selector(cancleBtn) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (string.length == 0) {
        UILabel *label = (UILabel *)[self viewWithTag:textField.text.length+99];
        label.hidden = YES;
        UIButton *button = (UIButton *)[self viewWithTag:201];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:RGB(50.0, 50.0, 50.0, 1) forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
    }else {
        if (textField.text.length > 4) {
            UIButton *button = (UIButton *)[self viewWithTag:201];
            button.backgroundColor = [UIColor colorWithRed:7.0/255.0 green:161/255.0 blue:243.0/225.0 alpha:1];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.userInteractionEnabled = YES;
            [button addTarget:self action:@selector(sureBtn) forControlEvents:UIControlEventTouchUpInside];
        }
        if (textField.text.length > 5) {
            UIButton *button = (UIButton *)[self viewWithTag:201];
            button.backgroundColor = [UIColor colorWithRed:7.0/255.0 green:161/255.0 blue:243.0/225.0 alpha:1];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            return NO;
        }
        else{
            UILabel *label = (UILabel *)[self viewWithTag:textField.text.length+100];
            label.hidden = NO;
            return YES;
        }
    }
    return YES;
}
//取消
- (void)cancleBtn{
    self.passwordField.text = nil;
    UIButton *button = (UIButton *)[self viewWithTag:201];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:RGB(50.0, 50.0, 50.0, 1) forState:UIControlStateNormal];
    button.userInteractionEnabled = NO;
    for (int index = 0; index < 6; index ++) {
        UILabel *label = (UILabel *)[self viewWithTag:100+index];
        label.hidden = YES;
    }
    NSLog(@"%@",self.passwordField.text);
    
    if ([self.delegate respondsToSelector:@selector(ClickPasswordCancleButton)]) {
        [self.delegate ClickPasswordCancleButton];
    }
}
//确定
- (void)sureBtn{
    
    NSLog(@"hello");
    if ([self.delegate respondsToSelector:@selector(ClickPasswordSureButton:)]) {
        [self.delegate ClickPasswordSureButton:_passwordField.text];
    }
}
    
@end
