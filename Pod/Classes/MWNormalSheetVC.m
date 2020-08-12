//
//  GMDoubleSheetVC.m
//  MyChevy
//
//  Created by SGMWH on 2019/10/7.
//  Copyright © 2019 Saic-GM. All rights reserved.
//

#import "MWNormalSheetVC.h"
#import "Masonry.h"
@interface MWNormalSheetVC ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (strong, nonatomic)NSMutableArray *btnArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content_height;

@end

@implementation MWNormalSheetVC
- (NSMutableArray *)actionArr{
    if (!_actionArr) {
        _actionArr = [NSMutableArray array];
    }
    return _actionArr;
}

- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}
-(void)didClickBtn:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(didClickAction:)]) {
            [self.delegate didClickAction:sender];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    for (int i = 0; i<self.actionArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setTitle:self.actionArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:btn];
        [self.btnArr addObject:btn];
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
        [btn addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(btn);
            make.height.mas_equalTo(1);
        }];
    }
    if (self.btnArr.count > 1) {
        [self.btnArr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:56 leadSpacing:0 tailSpacing:56+8];
        [self.btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
        }];
    }else{
        [self.btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(56);
        }];
    }
    self.content_height.constant = 56 + 8 + self.btnArr.count * 56;

    [self.cancel addTarget:self action:@selector(didClickCancel) forControlEvents:UIControlEventTouchUpInside];
}
-(void)didClickCancel{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)viewDidLayoutSubviews{
    CGFloat radius = 8.f; // 圆角大小
    UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight; // 圆角位置，全部位置
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.contentView.bounds;
    maskLayer.path = path.CGPath;
    self.contentView.layer.mask = maskLayer;
}
- (IBAction)didClickBackground:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
