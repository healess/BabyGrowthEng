//
//  GrowthBMIResultController.h
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceBookShareViewController.h"


@interface GrowthBMIResultController : UIViewController <FaceBookShareViewControllerDelegate>
{
	IBOutlet UIButton *btnCancel;
	
	IBOutlet UILabel	*Gender;
	IBOutlet UILabel	*Year;//
	IBOutlet UILabel	*Month;//
	IBOutlet UILabel	*BMIValue;//
	IBOutlet UILabel	*BMIPercent;//
	
	IBOutlet UITextView	 *infoComment;//정보
	IBOutlet UIWebView	*infoWebComment;	//정보 2012.3.4 추가 by 서정범
	IBOutlet UIImageView *ivScale; //저울이미지
	
	IBOutlet UIButton		*btnFacebookShare;	//facebook 공유	
	
	NSTimer *timer;	//타이머
	int second;//초

}
@property (nonatomic,retain) IBOutlet UIButton *btnCancel;


@property(nonatomic,retain) IBOutlet UILabel *Gender;
@property(nonatomic,retain) IBOutlet UILabel *Year;
@property(nonatomic,retain) IBOutlet UILabel *Month;
@property(nonatomic,retain) IBOutlet UILabel *BMIValue;
@property(nonatomic,retain) IBOutlet UILabel *BMIPercent;
@property(nonatomic,retain) IBOutlet UITextView *infoComment;
@property(nonatomic,retain) IBOutlet UIWebView	*infoWebComment;	//정보 2012.3.4 추가 by 서정범
@property(nonatomic,retain) IBOutlet UIImageView  *ivScale; //저울이미지

@property(retain,nonatomic) NSTimer *timer; //타이머
@property (nonatomic, assign) int second;

-(void) measureBMIPercent:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight Weight:(NSString*)pWeight;
-(IBAction)btnCancelTouched;
-(IBAction)btnFacebookShareTouched; //facebook 공유버튼
-(UIImage *)captureScreenInRect:(CGRect)captureFrame; //화면캡쳐

@end
