//
//  InfantData.h
//  Infant
//
//  Created by JUNG BUM SEO/SU SANG KIM on 11. 10. 23..
//  Copyright 2011 JUNG BUM SEO/SU SANG KIM All rights reserved.
//
/*
 DB에서 출력 값
 */

#import <Foundation/Foundation.h>


@interface InfantData : NSObject
{
	NSInteger mIndex;//시퀀스
	NSString *mPercent;//백분위수
	//이력조회관련 추가
	NSInteger mIndex2;
	NSString *mName;
	NSString *mGender;
	NSString *mDate;
	NSString *mYear;
	NSString *mMonth;
	NSString *mHeight;
	NSString *mHeightPercent;
	NSString *mWeight;
	NSString *mWeightPercent;
	NSString *mLength;
	NSString *mLengthPercent;

}

@property(nonatomic, assign) NSInteger mIndex;
@property(nonatomic, retain) NSString *mPercent;

@property(nonatomic, assign) NSInteger mIndex2;
@property(nonatomic, retain) NSString *mName;
@property(nonatomic, retain) NSString *mGender;
@property(nonatomic, retain) NSString *mDate;
@property(nonatomic, retain) NSString *mYear;
@property(nonatomic, retain) NSString *mMonth;
@property(nonatomic, retain) NSString *mHeight;
@property(nonatomic, retain) NSString *mHeightPercent;
@property(nonatomic, retain) NSString *mWeight;
@property(nonatomic, retain) NSString *mWeightPercent;
@property(nonatomic, retain) NSString *mLength;
@property(nonatomic, retain) NSString *mLengthPercent;


-(id)initWithData:(NSInteger)pIndex Percent:(NSString*)pPercent ;
-(id)initHistoryWithData:(NSInteger)pIndex2 Name:(NSString*)pName Gender:(NSString*)pGender Date:(NSString*)pDate Year:(NSString*)pYear Month:(NSString*)pMonth Height:(NSString*)pHeight HeightPercent:(NSString*)pHeightPercent Weight:(NSString*)pWeight WeightPercent:(NSString*)pWeightPercent Length:(NSString*)pLength LengthPercent:(NSString*)pLengthPercent;
-(id)initChildNameWithData:(NSInteger)pName;


@end
