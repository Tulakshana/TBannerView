//
//  ViewController.m
//  TBannerViewDemo
//

//  Copyright (c) 2015 Tulakshana. All rights reserved.
//

#import "ViewController.h"

#import "TBannerView.h"

@interface ViewController ()<TBannerViewDelegate>{
    IBOutlet TBannerView *bView,*bView2;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    bView.delegate = self;
    bView2.delegate = self;
    [bView reloadData];
    [bView2 reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TBannerViewDelegate

- (NSArray *)tBannerViewImageURLs:(TBannerView *)bannerView{
    return [NSArray arrayWithObjects:[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/w%3D2048/sign=ed59838948ed2e73fce9812cb339a08b/58ee3d6d55fbb2fb9835341f4d4a20a44623dca5.jpg"],[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/w%3D2048/sign=5ad7fab780025aafd33279cbcfd5aa64/8601a18b87d6277f15eb8e4f2a381f30e824fcc8.jpg"],[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/w%3D2048/sign=df5d0b61cdfc1e17fdbf8b317ea8f703/0bd162d9f2d3572c8d2b20ab8813632763d0c3f8.jpg"],[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/w%3D2048/sign=a11d7b94552c11dfded1b823571f63d0/eaf81a4c510fd9f914eee91e272dd42a2934a4c8.jpg"], nil];
}
- (int)tBannerViewNumberItemsPerPage:(TBannerView *)bannerView{
    if (bannerView.tag == 1) {
        return 1;
    }
    return 3;
}


- (void)tBannerView:(TBannerView *)bannerView didSelectedAtIndex:(int)index{
    NSLog(@"didSelectedAtIndex %d",index);
}
- (int)tBannerViewAutoPlayTimeInterval:(TBannerView *)bannerView{
    return 3.0;
}

- (UIColor *)tBannerViewPageIndicatorTintColor:(TBannerView *)bannerView{
    if (bannerView.tag == 0) {
        return [UIColor whiteColor];
    }
    return [UIColor lightGrayColor];
}
- (UIColor *)tBannerViewCurrentPageIndicatorTintColor:(TBannerView *)bannerView{

    return [UIColor darkGrayColor];
}

@end
