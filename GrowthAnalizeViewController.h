//
//  GrowthAnalizeViewController.h
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@protocol RootViewControllerDelegate;


@interface GrowthAnalizeViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{

	IBOutlet UIButton *btnGoToGrowthAnalizeResult;
	IBOutlet UIButton *btnCancel;
	IBOutlet UISegmentedControl *segGender;
	
	
	/*	IBOutlet UITextField *textField;
	 IBOutlet UITextField *textField2;
	 IBOutlet UITextField *textField3;
	 IBOutlet UITextField *textField4;
	 IBOutlet UITextField *textField5;
	 IBOutlet UITextField *textField6;*/
	
	id<RootViewControllerDelegate> delegate;//값 전달 딜리게이트
	
	/*    NSMutableArray *arrayNo;
	 NSMutableArray *arrayNo2;
	 NSMutableArray *arrayNo3;
	 NSMutableArray *arrayNo4;
	 NSMutableArray *arrayNo5;
	 NSMutableArray *arrayNo6;*/
	
	//피커뷰 반영
	UIPickerView *genderValuePicker; //성별 입력 피커
	UIPickerView *yearValuePicker; //나이 년도 입력 피커
	UIPickerView *monthValuePicker; //나이 달 입력 피커
	UIPickerView *heightValuePicker;//키 입력 피커
	UIPickerView *weightValuePicker;//몸무게 입력 피커
	UIPickerView *lengthValuePicker;//머리둘레 입력 피커
	
	NSArray *genderValues;//성별 입력 피커 내 배열값
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
	NSArray *lengthValues;//머리둘레 입력 피커 내 배열값
	NSArray *lengthValues2;//머리둘레 입력 피커 내 배열값
	NSArray *lengthValues3;//머리둘레 입력 피커 내 배열값
	
	
	IBOutlet UIButton *genderTypeBtn;//성별 입력 피커 호출 및 값 세팅 버튼
	IBOutlet UIButton *yearBtn;
	IBOutlet UIButton *monthBtn;
	IBOutlet UIButton *heightBtn;
	IBOutlet UIButton *weightBtn;
	IBOutlet UIButton *lengthBtn;	
	
	//툴바사용
	UIToolbar                       *toolbar;
	
	//미국단위 추가 (2012.10)
	IBOutlet UISegmentedControl *segHeight;
	IBOutlet UISegmentedControl *segWeight;
	IBOutlet UISegmentedControl *segLength;
	NSString *segHeightValue;
	NSString *segWeightValue;
	NSString *segLengthValue;
	
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
	
	UIPickerView *lengthInValuePicker;//머리둘레(In) 입력 피커
	NSArray *lengthInValues;//머리둘레(In) 입력 피커 내 배열값
	NSArray *lengthInValues2;//머리둘레(In) 입력 피커 내 배열값
	NSArray *lengthInValues3;//머리둘레(In) 입력 피커 내 배열값
	NSArray *lengthInValues4;//머리둘레(In) 입력 피커 내 배열값
	//미국단위 추가 (2012.10)
}
//툴바사용
@property (nonatomic, retain) UIToolbar   *toolbar;


@property (nonatomic,retain) IBOutlet UIButton *btnGoToGrowthAnalizeResult;
@property (nonatomic,retain) IBOutlet UIButton *btnCancel;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segGender;



-(IBAction)btnGoToGrowthAnalizeResultTouched;
-(IBAction)btnCancelTouched;

/*@property (nonatomic, retain) UITextField *textField;
 @property (nonatomic, retain) UITextField *textField2;
 @property (nonatomic, retain) UITextField *textField3;
 @property (nonatomic, retain) UITextField *textField4;
 @property (nonatomic, retain) UITextField *textField5;
 @property (nonatomic, retain) UITextField *textField6;*/
@property (nonatomic,assign) id<RootViewControllerDelegate> delegate;



-(IBAction)seeResultData;//결과보기

//피커뷰 반영 해당 버튼 클릭 시 피커 호출
-(IBAction) showGenderValuePicker;
-(IBAction) segGenderSelected;
-(IBAction) showYearValuePicker;
-(IBAction) showMonthValuePicker;
-(IBAction) showHeightValuePicker;
-(IBAction) showWeightValuePicker;
-(IBAction) showLengthValuePicker;
-(BOOL)checkInputValueValid:(NSString *)inputGender Year:(NSString*)inputYear Month:(NSString*)inputMonth Height:(NSString*)inputHeight Weight:(NSString*)inputWeight Length:(NSString*)inputLength;
//피커뷰 반영

//미국단위 추가 (2012.10)
@property (nonatomic,retain) IBOutlet UISegmentedControl *segHeight;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segWeight;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segLength;
-(IBAction) segHeightSelected;
-(IBAction) segWeightSelected;
-(IBAction) segLengthSelected;
//미국단위 추가 (2012.10)

@end

@protocol RootViewControllerDelegate<NSObject>;

@required

-(void) rootViewControllerDidEnd:(NSString*)pGender Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight Weight:(NSString*)pWeight Length:(NSString*)pLength;


@end
