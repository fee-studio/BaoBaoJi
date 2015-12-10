//
//  YIModuleItemView.m
//  BaoBaoJi
//
//  Created by efeng on 11/24/15.
//  Copyright © 2015 buerguo. All rights reserved.
//

#import "YIModuleItemView.h"

@implementation YIModuleItemView

+ (instancetype)viewWithTitle:(NSString *)title content:(NSString *)content customView:(UIView *)customView {
    return [[self alloc] initWithTitle:title subTitle:nil content:content customView:customView images:nil];
}

+ (instancetype)viewWithTitle:(NSString *)title subTitle:(NSString *)subTitle content:(NSString *)content images:(NSArray *)images {
    return [[self alloc] initWithTitle:title subTitle:subTitle content:content customView:nil images:images];
}

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                      content:(NSString *)content
                   customView:(UIView *)customView
                       images:(NSArray *)images {
    self = [super init];
    if (self) {
        self.title = title;
        self.subTitle = subTitle;
        self.content = content;
        self.images = images;
        self.customView = customView;
        self.backgroundColor = [UIColor whiteColor];
        [self loadSubviews];
    }
    
    return self;
}

- (void)loadSubviews {
    UIView *lastView = nil;

	UILabel *timeLbl = [[UILabel alloc] init];
	timeLbl.numberOfLines = 1;
	timeLbl.font = kAppBigFont;
	timeLbl.textColor = kAppDeepColor;
	[timeLbl setText:@"1209"];
	[self addSubview:timeLbl];
	
	[timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self);
		make.left.equalTo(self);
		make.right.mas_lessThanOrEqualTo(self);
		make.width.equalTo(@50);
	}];
	
	
	
    if (self.title) {
        UILabel *titleLbl = [[UILabel alloc] init];
        titleLbl.numberOfLines = 0;
        titleLbl.font = kAppBoldMid2Font;
        titleLbl.textColor = kAppDeepColor;
        [titleLbl setText:_title];
        [self addSubview:titleLbl];
        
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).with.offset(50);
            make.right.mas_lessThanOrEqualTo(self);
        }];
        
        lastView = titleLbl;
    }
    
    if (self.subTitle) {
        UILabel *subTitleLbl = [[UILabel alloc] init];
        subTitleLbl.numberOfLines = 0;
        subTitleLbl.font = kAppMid2Font;
        subTitleLbl.textColor = [UIColor dangerColor];
        [subTitleLbl setText:_subTitle];
        subTitleLbl.font = [UIFont systemFontOfSize:10];
        [self addSubview:subTitleLbl];
        
        [subTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastView ? lastView.mas_right : @0).with.offset(50);
            make.right.mas_lessThanOrEqualTo(self); // 这个会导致主title过长的话，会使subTitle看不到啦。
            make.bottom.equalTo(lastView ? lastView : @0);
        }];
        
        lastView = subTitleLbl;
    }
    
    if (self.content) {
        UILabel *contentLbl = [[UILabel alloc] init];
        contentLbl.numberOfLines = 0;
        contentLbl.font = kAppMid2Font;
        contentLbl.textColor = kAppDeepColor;
        [contentLbl setText:_content];
        [self addSubview:contentLbl];
        
        [contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastView ? lastView.mas_bottom : @0);
            make.left.mas_equalTo(self).with.offset(50);
            make.right.mas_equalTo(self);
        }];
        
        lastView = contentLbl;
    }
    
    if (self.customView) {
        [self addSubview:_customView];
        [_customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastView ? lastView.mas_bottom : @0);
            make.left.mas_equalTo(self).with.offset(50);
            make.right.mas_equalTo(self);
        }];
        
        lastView = _customView;
    }
    
    if (self.images) {
        int numbers = 3;
        int separate = 1.f;
        CGFloat width = (mScreenWidth - 50.f - 20.f - (numbers-1)*separate) / numbers;
        CGFloat height = width;
        
        int curLine = 0;
        UIView *lastImageView;
        UIView *mostRightView;
        for (int i = 0; i < self.images.count; i++) {
            AVFile *imageFile = self.images[i];
            if (imageFile == nil || [imageFile isEqual:[NSNull null]]) {
                break;
            }
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            [imageView setClipsToBounds:YES];
            [self addSubview:imageView];
            
            if (imageFile && ![imageFile isKindOfClass:[NSNull class]]) {
                NSString *thumbnail = [imageFile getThumbnailURLWithScaleToFit:YES width:200 height:200];
                [imageView sd_setImageWithURL:[NSURL URLWithString:thumbnail]
                             placeholderImage:kAppPlaceHolderImage];
            }
            
            if (i / numbers == curLine) {
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastImageView ? lastImageView.mas_top : lastView.mas_bottom);
                    if (lastImageView) {
                        make.left.equalTo(lastImageView.mas_right).offset(separate);
                    } else {
                        make.left.equalTo(self).with.offset(50);
                    }
                    make.width.mas_equalTo(lastImageView ? lastImageView.mas_width : @(width));
                    make.height.mas_equalTo(lastImageView ? lastImageView.mas_width : @(height));
                }];
                if (i == (numbers - 1)) {
                    mostRightView = imageView;
                }
            } else {
                curLine = i / numbers;
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastImageView ? lastImageView.mas_bottom : lastView.mas_bottom).offset(separate);
                    make.left.equalTo(self).with.offset(50);
                    make.width.equalTo(lastImageView ? lastImageView.mas_width : @(width));
                    make.height.equalTo(lastImageView ? lastImageView.mas_width : @(height));
                }];
            }
            
            lastImageView = imageView;
        }
        
        if (lastImageView) {
            lastView = lastImageView;
        }
    }
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lastView ? lastView : @0);
    }];
}

@end
