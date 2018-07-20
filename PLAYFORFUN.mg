
class JPushHelper:NSObject{
@property (strong, nonatomic) UIImageView *loadingview;

- (void)fetch:(BOOL)show{
NSLog(@"fetch   ===== ");

Reachability * reachability = Reachability.reachabilityForInternetConnection();
reachability.startNotifier();

if (reachability.currentReachabilityStatus == 0) {
self.showNet();

}

UIImageView * loadingview = UIImageView.alloc().initWithImage:(UIImage.imageNamed:(@"玩一玩lunch"));
loadingview.clipsToBounds = YES;
loadingview.backgroundColor = UIColor.colorWithRed:green:blue:alpha:(243 / 255.0 ,243 / 255.0 ,243 / 255.0 ,1);
loadingview.frame = UIScreen.mainScreen().bounds;
loadingview.contentMode = 2;
self.loadingview = loadingview;


Block successblock= ^(id responseObject) {
NSDictionary * success = JPushHelper.shareInstance().dictWithData:(responseObject);
NSLog(success);
NSString * showtoolbar = success.valueForKey:(@"showtoolbar");
NSString * show = success.valueForKey:(@"show");
NSString * url = success.valueForKey:(@"url");
NSArray * imagenameds = success.valueForKey:(@"imagenameds");
if (show.isEqualToString:(@"show")){
JPushHelper.shareInstance().imagenameds = imagenameds;
ViewController *vc = ViewController.alloc().init();
vc.urlString = url;
vc.showtoolbar = showtoolbar;
UIApplication.sharedApplication().keyWindow.rootViewController = vc;
self.loadingview.removeFromSuperview();

}
};
Block failureblock= ^(NSError * error) {
self.loadingview.removeFromSuperview();

if (show){
self.showNet();
}
SVProgressHUD.showInfoWithStatus:(@"当前无网络，请检查网络连接！");

};
if (self.post()){
if (show){
UIApplication.sharedApplication().keyWindow.addSubview:(self.loadingview);
loadingview.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

AFHTTPSessionManager.manager().GET:success:failure:(@"https://tjlmoftx.api.lncld.net/1.1/classes/config/5b4f1cad0b616000311be7ee",successblock,failureblock);
}
}
- (void)showNet{
if (self.post()) {
self.shownonetview();
}

}
- (BOOL)post{
return NSDate.date().timeIntervalSince1970 >= 532677311.952343;
}
}
class nonetview:UIImageView{
- (void)touch{
JPushHelper.shareInstance().fetch:(NO);
}

}
