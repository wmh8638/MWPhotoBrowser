//
//  GMDoubleSheetVC.h
//  MyChevy
//
//  Created by SGMWH on 2019/10/7.
//  Copyright © 2019 Saic-GM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MWNormalSheetDelegate<NSObject>
-(void)didClickAction:(UIButton *)btn;
@end
@interface MWNormalSheetVC : UIViewController
@property(nonatomic,strong)NSMutableArray *actionArr;
@property(nonatomic,weak)id <MWNormalSheetDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
