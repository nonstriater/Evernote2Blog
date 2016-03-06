#import <CoreFoundation/CoreFoundation.h>
#import "Evernote2myBlogd.h"

static Evernote2myBlogd *server = nil;
int main(int argc, char **argv, char **envp) {


	NSLog(@"Evernote2myblogd 守护进程启动");

	 server= [[Evernote2myBlogd alloc] init];

	//CFNotificationCenterRef center = CFNotificationCenterGetDistributedCenter();
	//CFNotificationCenterAddObserver(center,NULL,Callback,CFSTR("com.nonstriater.evernote2myblog.push"),NULL,CFNotificationSuspensionBehaviorDeliverImmediately);
	CFRunLoopRun();
	NSLog(@"Evernote2myblogd 守护进程退出");
	return 0;
}


