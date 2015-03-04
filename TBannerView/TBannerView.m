//
//  TBannerView.m
//  TBannerViewDemo
//

//  Copyright (c) 2015 Tulakshana. All rights reserved.
//

#import "TBannerView.h"

#import "UIImageView+WebCache.h"

@interface TBannerView()<UIPageViewControllerDataSource>

@property (nonatomic,strong)UIPageViewController *pageControl;
@property (nonatomic,strong)NSArray *items;
@property (nonatomic)int pageCount,currentPage;
@property (nonatomic,strong)NSTimer *timer;

@end

@implementation TBannerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc{
    if (self.timer) {
        [self.timer invalidate];
    }
}

#pragma mark -
- (void)reloadData{

    
    [self setupElements];
    
    [self loadFirstPage];
    
}

- (void)loadFirstPage{
    self.items = [self.delegate tBannerViewImageURLs:self];
    self.pageCount = (int)[self.items count]/[self.delegate tBannerViewNumberItemsPerPage:self];
    if (([self.items count]%[self.delegate tBannerViewNumberItemsPerPage:self])>0) {
        self.pageCount++;
    }
    
    NSArray *viewControllers = [NSArray arrayWithObjects:[self viewControllerAtIndex:0], nil];
    [self.pageControl setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:TRUE completion:nil];
}

- (void)setupElements{
    if (self.pageControl == nil) {
        self.pageControl = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        self.pageControl.view.frame = self.bounds;
        self.pageControl.dataSource = self;
        [self addSubview:self.pageControl.view];
        
        [self setupPageControlAppearance];
    }
    
    if (self.timer == nil) {
        if ([self.delegate respondsToSelector:@selector(tBannerViewAutoPlayTimeInterval:)]) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:[self.delegate tBannerViewAutoPlayTimeInterval:self] target:self selector:@selector(changePage) userInfo:nil repeats:TRUE];
        }
        

    }
}

- (void)changePage{
    self.currentPage++;
    if (self.currentPage > (self.pageCount -1)){
        self.currentPage = 0;
    }
    NSArray *viewControllers = [NSArray arrayWithObjects:[self viewControllerAtIndex:self.currentPage], nil];
    [self.pageControl setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:TRUE completion:nil];
}

#pragma mark - UIPageViewController Datasource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{

    int tag = (int)viewController.view.tag;

    
    return [self prevPage:tag];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    int tag = (int)viewController.view.tag;

    return [self nextPage:tag];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return self.pageCount;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return self.currentPage;
}

#pragma mark - 

- (UIViewController *)nextPage:(int)tag{

    tag++;
    if (tag > (self.pageCount -1)){
        tag = 0;
    }
    return [self viewControllerAtIndex:tag];
}

- (UIViewController *)prevPage:(int)tag{
    tag--;
    if (tag < 0) {
        tag = self.pageCount - 1;
    }
    return [self viewControllerAtIndex:tag];
}

- (UIViewController *)viewControllerAtIndex:(int)index{
    NSLog(@"viewControllerAtIndex %d",index);
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.tag = index;

    
    int x = 0;
    int offset = 5;
    int height = CGRectGetHeight(self.bounds) - 30;
    int count = [self.delegate tBannerViewNumberItemsPerPage:self];
    int width = (CGRectGetWidth(self.bounds)/count);
    index = index * count;

    for (int i = 0; i < count; i++) {
        
        int itemIndex = index + i;
        NSLog(@"itemIndex %d",itemIndex);
        if (itemIndex<[self.items count]) {
            NSURL *url = [self.items objectAtIndex:index+i];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, width, height)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [imageView sd_setImageWithURL:url];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = imageView.frame;
            button.tag = index + i;
            [button addTarget:self action:@selector(imageTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            [vc.view addSubview:imageView];
            [vc.view addSubview:button];
        }
        x = x + width + offset;
    }
    
    
    return vc;

}

- (void)imageTapped:(id)sender{
    UIButton *button = (UIButton *)sender;
    
    if ([self.delegate respondsToSelector:@selector(tBannerView:didSelectedAtIndex:)]) {
        [self.delegate tBannerView:self didSelectedAtIndex:(int)button.tag];
    }
}

- (void)setupPageControlAppearance
{
    UIPageControl *pageControlAppearance = [UIPageControl appearanceWhenContainedIn:[UIPageViewController class], nil];
    if ([self.delegate respondsToSelector:@selector(tBannerViewPageIndicatorTintColor:)]) {
        pageControlAppearance.pageIndicatorTintColor = [self.delegate tBannerViewPageIndicatorTintColor:self];
    }
    if ([self.delegate respondsToSelector:@selector(tBannerViewCurrentPageIndicatorTintColor:)]) {
        pageControlAppearance.currentPageIndicatorTintColor = [self.delegate tBannerViewCurrentPageIndicatorTintColor:self];
    }
}

@end
