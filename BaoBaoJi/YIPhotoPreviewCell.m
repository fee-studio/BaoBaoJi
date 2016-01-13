//
//  YIPhotoPreviewCell.m
//  LoveWallpaper
//
//  Created by efeng on 14-8-19.
//  Copyright (c) 2014年 buerguo. All rights reserved.
//

#import "YIPhotoPreviewCell.h"
#define PADDING                  10


@interface YIPhotoPreviewCell ()


@property (nonatomic, strong, readwrite) UIActivityIndicatorView *indicatorView;

@end

@implementation YIPhotoPreviewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Clip subviews
        self.clipsToBounds = YES;
        CGRect frame = CGRectMake(0, 0, mScreenWidth, mScreenHeight);
        // Add image subview
        _previewIV = [[UIImageView alloc] initWithFrame:frame];
        _previewIV.backgroundColor = [UIColor whiteColor];
        _previewIV.contentMode = UIViewContentModeScaleAspectFill;
        _previewIV.clipsToBounds = NO;
        [self addSubview:_previewIV];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _indicatorView.color = [UIColor tealColor];
        [self addSubview:_indicatorView];
        _indicatorView.center = self.previewIV.center;
        
        [_indicatorView startAnimating];
        
    }
    return self;
}

- (void)setupCell:(YIPictureModel *)picture {
    [_previewIV sd_setImageWithURL:[YIConfigUtil screenPictureURL:picture.thumb] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_indicatorView stopAnimating];
    }];
}

- (void)setupCell:(YIPictureModel *)picture andOriSize:(CGSize)oriSize {    
    UIImage *placeholderImage = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:[[YIConfigUtil customPictureURL:picture.thumb andSize:oriSize] absoluteString]];
    [_previewIV sd_setImageWithURL:[YIConfigUtil screenPictureURL:picture.thumb] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_indicatorView stopAnimating];
    }];
}

- (CGRect)frameForPagingScrollView {
    CGRect frame = mScreenBounds;
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    return CGRectIntegral(frame);
}

@end
