//
//  LCUserEntity.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/17.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "LCUserEntity.h"
#import "LCFamilyEntity.h"


@implementation LCUserEntity

@dynamic area;
@dynamic babyRelation;
@dynamic birthday;
@dynamic nickName;
@dynamic avatar;
@dynamic isOnline;
@dynamic sex;
@dynamic babies;
//@dynamic curBaby;


+ (NSString *)parseClassName {
	return @"_User";
}


+ (void)reloadCurrentUserData; {
	__block LCUserEntity *user = [LCUserEntity currentUser];
	
	AVQuery *query = [LCUserEntity query];
	query.cachePolicy = kAVCachePolicyCacheThenNetwork;
	[query whereKey:@"objectId" equalTo:user.objectId];
	[query includeKey:@"curBaby"];
	[query includeKey:@"babies"];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (objects) {
			user = [objects lastObject];
		}
	}];
	
	
	AVQuery *familyQuery = [LCFamilyEntity query];
	[familyQuery whereKey:@"user" equalTo:user];
	[familyQuery includeKey:@"baby"]; // vip 想查出baby 必须includeKey baby
	[familyQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		NSMutableArray *babies = [NSMutableArray array];
		for(LCFamilyEntity *family in objects) {
			LCBabyEntity *baby = family.baby;
			[babies addObject:baby];
		}
		mGlobalData.user.babies = babies;
		mGlobalData.user.curBaby = [babies lastObject];
		[mGlobalData.user saveInBackground];
		
		if (mGlobalData.user.babies.count) {
			[mAppDelegate loadMainViewController];
		} else {
			[mAppDelegate loadAddBabyViewController];
		}
	}];
	
	mGlobalData.user = user;
}

@end
