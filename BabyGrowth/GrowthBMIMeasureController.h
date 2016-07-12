//
//  GrowthBMIMeasureController.h
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GrowthBMIMeasureDelegate;


@interface GrowthBMIMeasureController : UIViewController {
	IBOutlet UIButton *btnCancel;
	IBOutlet UIButton *btnGoToGrowthBMIResult;
	
	IBOutlet UISegmentedControl *segGender;
	

	
	//id<GrowthBMIMeasureDelegate> delegate;//값 전달 딜리게이트

	
	//피커뷰 반영
	UIPickerView *yearValuePicker; //나이 년도 입력 피커
	UIPickerView *monthValuePicker; //나이 달 입력 피커
	UIPickerView *heightValuePicker;//키 입력 피커
	UIPickerView *weightValuePicker;//몸무게 입력 피커
	
	NSArray *yearValues;//나이 년도 입력 피커 내 배열값
	NSArray *monthValues;//나이 달 입력 피커 내 배열값
	NSArray *heightValues;//키 입력 피커 내 배열값
	NSArray *heightValues2;//키 입력 피커 내 배열값
	NSArray *heightValues3;//키 입력 피커 내 배열값
	NSArray *heightValues4;//키 입력 피커 내 배열값
	NSArray *weightValues;//몸무게 입력 피커 내 배열값
	NSArray *weightValues2;//몸무게 입력 피커 내 배열값
	NSArray *weightValues3;//몸무게 입력 피커 내 배열값
	NSArray *weightValues4;//몸무게 입력 피커 내 배열값
	NSArray *weightValues5;//몸무게 입력 피커 내 배열값
	
	
	IBOutlet UIButton *genderTypeBtn;//성별 입력 피커 호출 및 값 세팅 버튼
	IBOutlet UIButton *yearBtn;
	IBOutlet UIButton *monthBtn;
	IBOutlet UIButton *heightBtn;
	IBOutlet UIButton *weightBtn;
	
	//툴바사용
	UIToolbar                       *toolbar;
	

	//미국단위 추가 (2012.10)
	IBOutlet UISegmentedControl *segHeight;
	IBOutlet UISegmentedControl *segWeight;
	NSString *segHeightValue;
	NSString *segWeightValue;
	
	UIPickerView *heightFtValuePicker;//키(ft) 입력 피커
	NSArray *heightFtValues;//키(ft) 입력 피커 내 배열값
	NSArray *heightFtValues2;//키(ft) 입력 피커 내 배열값
	NSArray *heightFtValues3;//키(ft) 입력 피커 내 배열값
	NSArray *heightFtValues4;//키(ft) 입력 피커 내 배열값
	NSArray *heightFtValues5;//키(ft) 입력 피커 내 배열값
	
	UIPickerView *weightLbValuePicker;//몸무게(lbs) 입력 피커
	NSArray *weightLbValues;//몸무게(lbs) 입력 피커 내 배열값
	NSArray *weightLbValues2;//몸무게(lbs) 입력 피커 내 배열값
	NSArray *weightLbValues3;//몸무게(lbs) 입력 피커 내 배열값
	NSArray *weightLbValues4;//몸무게(lbs) 입력 피커 내 배열값
	NSArray *weightLbValues5;//몸무게(lbs) 입력 피커 내 배열값	
	//미국단위 추가 (2012.10)
}

@property (nonatomic,retain) IBOutlet UIButton *btnGoToGrowthBMIResult;
@property (nonatomic,retain) IBOutlet UIButton *btnCancel;



-(IBAction)btnGoToGrowthBMIResultTouched;
-(IBAction)btnCancelTouched;

//툴바사용
@property (nonatomic, retain) UIToolbar   *toolbar;

@property (nonatomic,retain) IBOutlet UISegmentedControl *segGender;
//@property (nonatomic,assign) id<GrowthBMIMeasureDelegate> delegate;


//@property (nonatomic,assign) id<RootViewControllerDelegate> delegate;

//피커뷰 반영 해당 버튼 클릭 시 피커 호출
-(IBAction) segGenderSelected;
-(IBAction) showYearValuePicker;
-(IBAction) showMonthValuePicker;
-(IBAction) showHeightValuePicker;
-(IBAction) showWeightValuePicker;
//-(BOOL)checkInputValueValid:(NSString *)inputGender Year:(NSString*)inputYear Month:(NSString*)inputMonth Height:(NSString*)inputHeight Weight:(NSString*)inputWeight Length:(NSString*)inputLength;
//피커뷰 반영
//미국단위 추가 (2012.10)
@property (nonatomic,retain) IBOutlet UISegmentedControl *segHeight;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segWeight;
-(IBAction) segHeightSelected;
-(IBAction) segWeightSelected;
//미국단위 추가 (2012.10)

@end



@protocol GrowthBMIMeasureDelegate<NSObject>;

@required

-(void) measureBMIPercent:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight Weight:(NSString*)pWeight;


@end