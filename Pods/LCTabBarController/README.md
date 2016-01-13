# LCTabBarController
A amazing and highly customized tabBarController! You could almost customize 100% of the properties with LCTabBarController! 😍 ✨

![LCTabBarController](https://github.com/LeoiOS/LCTabBarController/blob/master/demo01.png)

````
In me the tiger sniffs the rose.

心有猛虎，细嗅蔷薇。
````

Welcome to visit my blog: http://LeoDev.me



**[中文介绍](https://github.com/LeoiOS/LCTabBarController/blob/master/README_zh-CN.md)**



## Feature

* Highly decoupled!
> Each control is a independent class! `-->` means "be possessed":
>
> LCTabBarBadge --> LCTabBarItem --> LCTabBar --> LCTabBarController

* Simple integration!
> Integration takes only one step: Just replace the `UITabBarController` word in your `AppDelegate.m` with `LCTabBarController` to complete the integration!

* Non-Pollution!
> `LCTabBarController` has all the functions of `UITabBarController`, and NO any intrusion behavior!
>
> So, even if your project is complete, you could integrated at any time! You could also change back to `UITabBarController`! (But I 200% believe you won't do it!)

* Highly customized!
> You can freely set the following properties, you can also choose to modify the code directly!
>
> 1. tabBar title color
>
> 2. tabbar title font
>
> 3. tabbar image ratio
>
> 4. tabbar badge frame
>
> 5. tabbar badge font
>
> 6. ...

* If you feel good, please give me a star, thank you very much! ⭐️
> I will keep update with new Issue, if you want to know my progress at any time, please click on the `watch` button in the upper right corner!



## Installation

LCTabBarController is available on [CocoaPods](https://cocoapods.org/). Just add the following to your project Podfile:

````ruby
pod "LCTabBarController"    # Podfile
````



## Non-CocoaPods Installation

Just drag the LCTabBarController folder into your project.



## Usage

* Inside your `AppDelegate.m`:
````objc
// Import header file
#import "LCTabBarController.h"

// 1. If you have already started the project, even if it's already done.
UITabBarController *tabBarC = [[UITabBarController alloc] init];
->
LCTabBarController *tabBarC = [[LCTabBarController alloc] init];

// 2. If you're just starting to write a new project
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    [self.window makeKeyAndVisible];

    // Other code
    HomeVC *vc1 = [[HomeVC alloc] init];
    vc1.view.backgroundColor = [UIColor whiteColor];
    vc1.tabBarItem.badgeValue = @"23";
    vc1.title = @"Home";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];

    // vc2 vc3 ...

    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor yellowColor];
    vc4.tabBarItem.badgeValue = @"99+";
    vc4.title = @"Profile";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_profile_selected"];


    UINavigationController *navC1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController *navC2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController *navC3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    UINavigationController *navC4 = [[UINavigationController alloc] initWithRootViewController:vc4];



    /**************************************** Key Code ****************************************/

    LCTabBarController *tabBarC = [[LCTabBarController alloc] init];

    tabBarC.viewControllers = @[navC1, navC2, navC3, navC4];

    self.window.rootViewController = tabBarC;

    /******************************************************************************************/



    return YES;
}
````

* **Done!**

* You can change the following properties with `LCTabBarController` object, other more attributes can be directly read code changes!

  ````objc
  /**************************************** Key Code ****************************************/

  LCTabBarController *tabBarC    = [[LCTabBarController alloc] init];

  // look here, you should set this properties before `- setViewControllers:`
  tabBarC.itemTitleFont          = [UIFont boldSystemFontOfSize:11.0f];
  tabBarC.itemTitleColor         = [UIColor greenColor];
  tabBarC.selectedItemTitleColor = [UIColor redColor];
  tabBarC.itemImageRatio         = 0.5f;
  tabBarC.badgeTitleFont         = [UIFont boldSystemFontOfSize:12.0f];

  tabBarC.viewControllers        = @[navC1, navC2, navC3, navC4];

  self.window.rootViewController = tabBarC;

  /******************************************************************************************/
  ````

  Than you could see like this:

  ![LCTabBarController](https://github.com/LeoiOS/LCTabBarController/blob/master/CustomProperties.png)



## Example

![LCTabBarController](https://github.com/LeoiOS/LCTabBarController/blob/master/demo01.png)
---
![LCTabBarController](https://github.com/LeoiOS/LCTabBarController/blob/master/demo02.png)
---
![LCTabBarController](https://github.com/LeoiOS/LCTabBarController/blob/master/demo03.png)
---
![LCTabBarController](https://github.com/LeoiOS/LCTabBarController/blob/master/demo04.png)



## Release


### V 1.2.5

* Change custom way, experience better!


### V 1.2.2

*
    ````objc
    tabBarItem.imageView.contentModel == UIViewContentModeScaleAspectFit;

    -->

    tabBarItem.imageView.contentModel == UIViewContentModeCenter;
    ````


### V 1.2.1

* Fix frame: `tabBarBadge`'s `x`.


### V 1.2.0

* for you!


### V 1.1.0

* for LanMeng Tec.
* V 1.1.x will for LanMeng Tec. only.


### V 1.0.6

* for LanMeng Tec.


### V 1.0.5

*
    ````objc
    tabBarItem.imageView.contentModel == UIViewContentModeCenter;

    -->

    tabBarItem.imageView.contentModel == UIViewContentModeScaleAspectFit;
    ````


### V 1.0.3

* Delete some logs.
* Update demo images.


### V 1.0.2

* UI adjustment.


### V 1.0.1

* Bug fixed.


### V 1.0.0

* Init Commit.
* [CocoaPods](https://cocoapods.org/) support.



## Support

If you have any questions, please commit a [Issues](https://github.com/LeoiOS/LCTabBarController/issues/new)! Thx!

Email: <liucsuper@gmail.com> & <leoios@sina.com>

Blog: http://LeoDev.me & http://www.leodong.com



## License

[MIT License](http://opensource.org/licenses/MIT)
