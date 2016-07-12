//
//  GrowthEstimateResultViewController.h
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceBookShareViewController.h"

@interface GrowthEstimateResultViewController : UIViewController <FaceBookShareViewControllerDelegate>
{

	IBOutlet UIButton *btnCancel;
	IBOutlet UILabel	*result_Boy;//키 분위수
	IBOutlet UILabel	*result_Girl;//몸무게 분위수
	
	IBOutlet UILabel	*pMotherHeight;//아빠키 파라미터
	IBOutlet UILabel	*pFatherHeight;//엄마키 파라미터
	
	IBOutlet UILabel	*Gender;
	IBOutlet UILabel	*Year;//
	IBOutlet UILabel	*Month;//
	IBOutlet UILabel	*Height;//
	IBOutlet UILabel	*HeightPercent;//
	IBOutlet UILabel	*FutureHeight;//
	IBOutlet UITextView	*infoComment;//정보
	IBOutlet UIWebView	*infoWebComment;	//정보 2012.3.4 추가 by 서정범
	
	IBOutlet UIImageView *ivGiraffe; //기린^^
	IBOutlet UIButton		*btnFacebookShare;	//facebook 공유
	
	NSTimer *timer;	//타이머
	int second;//초
}
@property(nonatomic,retain) IBOutlet UIButton *btnCancel;


@property (nonatomic,retain) IBOutlet UILabel *result_Boy;
@property (nonatomic,retain) IBOutlet UILabel *result_Girl;

@property (nonatomic,retain) IBOutlet UILabel *pMotherHeight;
@property (nonatomic,retain) IBOutlet UILabel *pFatherHeight;
@property (nonatomic,retain) IBOutlet UILabel *Gender;
@property (nonatomic,retain) IBOutlet UILabel *Year;
@property (nonatomic,retain) IBOutlet UILabel *Month;
@property (nonatomic,retain) IBOutlet UILabel *Height;
@property (nonatomic,retain) IBOutlet UILabel *HeightPercent;
@property (nonatomic,retain) IBOutlet UILabel *FutureHeight;
@property (nonatomic,retain) IBOutlet UITextView *infoComment;
@property (nonatomic,retain) IBOutlet UIWebView		*infoWebComment;	//정보 2012.3.4 추가 by 서정범

@property(retain,nonatomic) NSTimer *timer; //타이머
@property (nonatomic, assign) int second;
@property (nonatomic,retain) IBOutlet UIImageView  *ivGiraffe; //기린^^

-(IBAction)btnCancelTouched;
-(void) calcualteCurrentHeightValue:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight HeightPercent:(NSString*)pHeightPercent Father:(NSString *)inputFather Mother:(NSString*)inputMother;
-(IBAction)btnFacebookShareTouched; //facebook 공유버튼
-(UIImage *)captureScreenInRect:(CGRect)captureFrame; //화면캡쳐

@end
