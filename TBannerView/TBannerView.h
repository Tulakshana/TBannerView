//
//  TBannerView.h
//  TBannerViewDemo
//
//  Created by Riverview Labs on 4/3/15.
//  Copyright (c) 2015 Tulakshana. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TBannerView;

@protocol TBannerViewDelegate <NSObject>

- (NSArray *)tBannerViewImageURLs:(TBannerView *)bannerView;
- (int)tBannerViewNumberItemsPerPage:(TBannerView *)bannerView;

@optional
- (void)tBannerView:(TBannerView *)bannerView didSelectedAtIndex:(int)index;
- (int)tBannerViewAutoPlayTimeInterval:(TBannerView *)bannerView;
- (UIColor *)tBannerViewPageIndicatorTintColor:(TBannerView *)bannerView;
- (UIColor *)tBannerViewCurrentPageIndicatorTintColor:(TBannerView *)bannerView;

@end

@interface TBannerView : UIView

@property (nonatomic,weak)id<TBannerViewDelegate>delegate;

- (void)reloadData;

@end
