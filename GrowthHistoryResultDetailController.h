//
//  RootViewController.h
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GrowthHistoryResultDetailController : UIViewController 
{
	IBOutlet UIButton *btnCancel;//돌아가기
	IBOutlet UIButton *btnDeleteHistory;//이력1건삭제
	NSInteger delIndex; //삭제할 이력의 인덱스..
}
@property (nonatomic) NSInteger delIndex;
-(IBAction)btnCancelTouched;
-(IBAction)btnDeleteHistoryTouched;


@end
