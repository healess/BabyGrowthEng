//
//  GrowthEstimateViewController.h
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CalculateDelegate;


@interface GrowthEstimateViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
{
	IBOutlet UIButton *btnGoToGrowthEstimateResult;
	IBOutlet UIButton *btnCancel;
	IBOutlet UIButton *fatherHeightBtn;
	IBOutlet UIButton *motherHeightBtn;
	
	UIPickerView *fatherHeightValuePicker;//몸무게 입력 피커
	UIPickerView *motherHeightValuePicker;//머리둘레 입력 피커
	
	NSArray *fatherHeightValue;//아빠키 입력 피커 내 배열값
	NSArray *fatherHeightValue2;//아빠키 입력 피커 내 배열값
	NSArray *fatherHeightValue3;//아빠키 입력 피커 내 배열값
	NSArray *fatherHeightValue4;//아빠키 입력 피커 내 배열값

	NSArray *motherHeightValue;//엄마키 입력 피커 내 배열값	
	NSArray *motherHeightValue2;//엄마키 입력 피커 내 배열값	
	NSArray *motherHeightValue3;//엄마키 입력 피커 내 배열값	
	NSArray *motherHeightValue4;//엄마키 입력 피커 내 배열값	

	id<CalculateDelegate> delegate;//값 전달 딜리게이트
	//툴바사용
	UIToolbar                       *toolbar;
	
	IBOutlet UILabel *heightPercentValue;
	IBOutlet UILabel *heightValue;
	IBOutlet UILabel *yearValue;
	IBOutlet UILabel *monthValue;
	IBOutlet UILabel *genderValue;

	//미국단위 추가 (2012.10)
	IBOutlet UISegmentedControl *segHeight;
	NSString *segHeightValue;
	UIPickerView *heightFtValuePicker;//키(ft) 입력 피커
	NSArray *heightFtValues;//키(ft) 입력 피커 내 배열값
	NSArray *heightFtValues2;//키(ft) 입력 피커 내 배열값
	NSArray *heightFtValues3;//키(ft) 입력 피커 내 배열값
	NSArray *heightFtValues4;//키(ft) 입력 피커 내 배열값
	NSArray *heightFtValues5;//키(ft) 입력 피커 내 배열값
	
	IBOutlet UISegmentedControl *segHeight_2;
	NSString *segHeightValue_2;
	UIPickerView *heightFtValuePicker_2;//키(ft) 입력 피커
	NSArray *heightFtValues_2;//키(ft) 입력 피커 내 배열값
	NSArray *heightFtValues2_2;//키(ft) 입력 피커 내 배열값
	NSArray *heightFtValues3_2;//키(ft) 입력 피커 내 배열값
	NSArray *heightFtValues4_2;//키(ft) 입력 피커 내 배열값
	NSArray *heightFtValues5_2;//키(ft) 입력 피커 내 배열값
	//미국단위 추가 (2012.10)	
}
//툴바사용
@property (nonatomic, retain) UIToolbar   *toolbar;

@property(nonatomic,retain) IBOutlet UIButton *btnGoToGrowthEstimateResult;
@property(nonatomic,retain) IBOutlet UIButton *btnCancel;
@property(nonatomic,retain) IBOutlet UIButton *fatherHeightBtn;
@property(nonatomic,retain) IBOutlet UIButton *motherHeightBtn;
@property (nonatomic,assign) id<CalculateDelegate> delegate;
@property(nonatomic,retain) IBOutlet UILabel *heightPercentValue;
@property(nonatomic,retain) IBOutlet UILabel *heightValue;
@property(nonatomic,retain) IBOutlet UILabel *yearValue;
@property(nonatomic,retain) IBOutlet UILabel *monthValue;
@property(nonatomic,retain) IBOutlet UILabel *genderValue;

-(void)calcualteBabyHeightPercent:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight;
-(IBAction)btnGoToGrowthEstimateResult;
-(IBAction)btnCancelTouched;

-(IBAction) showFatherHeightPicker;
-(IBAction) showMotherHeightPicker;
//미국단위 추가 (2012.10)
@property (nonatomic,retain) IBOutlet UISegmentedControl *segHeight;
-(IBAction) segHeightSelected;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segHeight_2;
-(IBAction) segHeightSelected_2;

//미국단위 추가 (2012.10)
@end


@protocol CalculateDelegate<NSObject>;

@required

//-(void) calcualteParentHeightValue:(NSString*)pfather Mother:(NSString*)pMother;
-(void) calcualteCurrentHeightValue:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight HeightPercent:(NSString*)pHeightPercent Father:(NSString*)pfather Mother:(NSString*)pMother;


@end

