//
//  GrowthAnalizeResultViewController.h
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrowthAnalizeViewController.h"
#import "FaceBookShareViewController.h"
#import "BABYGROWTHAppDelegate.h"

@protocol GrowthAnalizeCommentDelegate;


@interface GrowthAnalizeResultViewController : UIViewController <FaceBookShareViewControllerDelegate>
{
	IBOutlet UIButton *btnCancel;
	IBOutlet UIButton *btnGoToGrowthAnalizeResultComment;

	IBOutlet UILabel	*result_Height;//키 분위수
	IBOutlet UILabel	*result_Weight;//몸무게 분위수
	IBOutlet UILabel	*result_Length;//머리둘레 분위 수
	
	IBOutlet UILabel	*pGender;//키 몇살
	IBOutlet UILabel	*pYear;//키 몇살
	IBOutlet UILabel	*pMonth;//키 개월
	IBOutlet UILabel	*pLength;//머리길이
	IBOutlet UILabel	*pHeight;//키
	IBOutlet UILabel	*pWeight;//몸무게 
	
	IBOutlet UIButton	 *btnSaveHistory;	//성장저장
	IBOutlet UITextField *inputName;
	
	IBOutlet UIButton		*btnFacebookShare;	//facebook 공유	
}
@property(nonatomic,retain) IBOutlet UIButton *btnCancel;
@property(nonatomic,retain) IBOutlet UIButton *btnGoToGrowthAnalizeResultComment;
@property(nonatomic,retain) IBOutlet UIButton *btnFacebookShare;

@property(nonatomic,retain) IBOutlet UIButton *btnSaveHistory;
@property(nonatomic,retain) IBOutlet UITextField *inputName;

-(IBAction)btnGoToGrowthAnalizeResultCommentTouched;
-(IBAction)btnCancelTouched;
-(IBAction)btnSaveHistoryTouched;
-(IBAction)inputName;
-(IBAction)inputNameBeginEdit;
-(IBAction)btnFacebookShareTouched; //facebook 공유버튼
-(UIImage *)captureScreenInRect:(CGRect)captureFrame; //화면캡쳐

@property (nonatomic,retain) IBOutlet UILabel *result_Height;
@property (nonatomic,retain) IBOutlet UILabel *result_Weight;
@property (nonatomic,retain) IBOutlet UILabel *result_Length;

@property (nonatomic,retain) IBOutlet UILabel *pGender;
@property (nonatomic,retain) IBOutlet UILabel *pYear;
@property (nonatomic,retain) IBOutlet UILabel *pMonth;
@property (nonatomic,retain) IBOutlet UILabel *pLength;
@property (nonatomic,retain) IBOutlet UILabel *pHeight;
@property (nonatomic,retain) IBOutlet UILabel *pWeight;
@end

@protocol GrowthAnalizeCommentDelegate<NSObject>;

@required

//-(void) seeGrowthAnalizeComment:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeightPercent Weight:(NSString*)pWeightPercent Length:(NSString*)pLengthPercent;
-(void) seeGrowthAnalizeComment:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeightPercent Weight:(NSString*)pWeightPercent Length:(NSString*)pLengthPercent;


@end
