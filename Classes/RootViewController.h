//
//  RootViewController.h
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
{
	IBOutlet UIButton *btnGoToGrowthAnalize;
	IBOutlet UIButton *btnGoToGrowthEstimate;
	IBOutlet UIButton *btnGoToGrowthBMIMeasure;
	IBOutlet UIButton *btnGoToGrowthHistory;
	IBOutlet UIButton *btnGoToFaceBookPage;//페이스북 페이지로

	NSTimer *timer;	//타이머
	int second;//초ㅓ
}

@property (nonatomic,retain) IBOutlet UIButton *btnGoToGrowthAnalize;
@property (nonatomic,retain) IBOutlet UIButton *btnGoToGrowthEstimate;
@property (nonatomic,retain) IBOutlet UIButton *btnGoToGrowthBMIMeasure;
@property (nonatomic,retain) IBOutlet UIButton *btnGoToGrowthHistory;
@property (nonatomic,retain) IBOutlet UIButton *btnGoToFaceBookPage;

@property(retain,nonatomic) NSTimer *timer; //타이머
@property (nonatomic, assign) int second;

-(IBAction)btnGoToGrowthAnalizeTouched;
-(IBAction)btnGoToGrowthEstimateTouched;
-(IBAction)btnGoToGrowthBMIMeasureTouched;
-(IBAction)btnGoToGrowthHistoryTouched;
-(IBAction)btnGoToFaceBookPageTouched; //페이스북 페이지로

@end
