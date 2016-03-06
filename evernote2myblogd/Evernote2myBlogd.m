
#import "Evernote2myBlogd.h"
#import "Private/CPDistributedMessagingCenter.h"
#import "Private/rocketbootstrap.h"

@implementation Evernote2myBlogd

- (id)init{

	self = [super init];
	if (self)
	{
		CPDistributedMessagingCenter *messagingCenter = [CPDistributedMessagingCenter centerNamed:@"com.nonstriater.evernote2myblogd"];
		rocketbootstrap_distributedmessagingcenter_apply(messagingCenter);
		[messagingCenter runServerOnCurrentThread];
		[messagingCenter registerForMessageName:@"com.nonstriater.evernote2myblogd.push" target:self selector:@selector(handleMessageName:userInfo:)];
	}

	return self;
}

- (void)dealloc{
	[super dealloc];
	NSLog(@"evernote2myBlogd release!");
}



- (void)handleMessageName:(NSString *)name userInfo:(NSDictionary *)userInfo{
	NSLog(@"Evernote2myblogd: receive push request:name=%@,userInfo=%@",name,userInfo);
	NSString *postPath = [userInfo valueForKey:@"postPath"];
	NSString *category = [userInfo valueForKey:@"category"];
	[self pushPostWithCategory:category postPath:postPath];
}

- (void)pushPostWithCategory:(NSString *)category postPath:(NSString *)filePath{

	NSString *postPath = @"/var/mobile/Applications/06033C5E-7EBE-408B-8A44-EFB2B48526A9/Library/Preferences/com.evernote.iPhone.Evernote.plist";
    NSString *cmd = [NSString stringWithFormat:@"sh -x /var/root/push2Blog.sh cate1 %@ > /var/root/a.txt",postPath];
            
    const char *ccmd = [cmd cStringUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Evernote2myblogd:开始执行脚本...%s",ccmd);
    int ret = system(ccmd);
    if(ret<0){
        NSLog(@"Evernote2myblogd:脚本执行失败:ret=%d",ret);
    }else if(ret == 0){
        NSLog(@"Evernote2myblogd:脚本执行成功:%@",cmd);
    }else{
        NSLog(@"Evernote2myblogd:脚本执行成功:%@,ret=%d",cmd,ret);
    }

}


@end
