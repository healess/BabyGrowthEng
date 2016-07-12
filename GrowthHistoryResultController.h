//
//  RootViewController.h
//  BABYGROWTH
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BABYGROWTHAppDelegate.h"
#import "InfantData.h"
#import <sqlite3.h>
#import "FaceBookShareViewController.h"

@interface GrowthHistoryResultController : UIViewController <UITableViewDelegate, UITableViewDataSource, FaceBookShareViewControllerDelegate>
{
	IBOutlet UIButton *btnCancel;//메인으로
	IBOutlet UITableView *tableViewList;
	IBOutlet UITableViewCell *tableViewCell;
	InfantData *mData;
	IBOutlet UIButton	*nameBtn;
	IBOutlet UILabel	*Gender;//	
//	NSArray *childNameValues;//아이이름 배열값
	NSMutableArray *childNameValues;
	UIPickerView *childNamePicker; //성별 입력 피커
	UIToolbar                       *toolbar;
	IBOutlet UIButton		*btnFacebookShare;	//facebook 공유
	
	NSTimer *timer;	//타이머
	int second;//초
}
//툴바사용
@property (nonatomic, retain) UIToolbar   *toolbar;

@property (nonatomic,retain) IBOutlet UIButton *btnCancel;
@property (nonatomic,retain) IBOutlet UITableView *tableViewList;
@property (nonatomic,retain) IBOutlet UITableViewCell *tableViewCell;
@property (nonatomic,retain) IBOutlet InfantData *mData;
@property(nonatomic,retain) IBOutlet UILabel *Gender;

@property(retain,nonatomic) NSTimer *timer; //타이머
@property (nonatomic, assign) int second;

-(IBAction)btnCancelTouched;
//복수개의 아이 선택 시 호출
-(IBAction) selectChildName;

-(IBAction)btnFacebookShareTouched; //facebook 공유버튼
-(UIImage *)captureScreenInRect:(CGRect)captureFrame; //화면캡쳐

@end
