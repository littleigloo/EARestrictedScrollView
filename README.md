# EARestrictedScrollView

<p align="center">
<img src="Images/Demo.gif" width="200"/>
</p>

<p align="center">
<img src="https://img.shields.io/badge/SPM-Swift%20Package-FA7343?logo=Swift&style=for-the-badge&logoColor=white" alt="Swift Package">
<br>
<img src="https://img.shields.io/github/v/tag/epitonium/EARestrictedScrollView?color=9BD600&label=Release">
<img src="https://img.shields.io/badge/platform-iOS%20-4BC51D.svg?style=flat">
<img src="https://img.shields.io/badge/license-MIT-3a3a3a">
</p>

## Description

Swift Package 📦 **`UIScrollView` sublass with ability to restrict scrolling area.**

In plain `UIScrollView` only `contentSize` can be changed, but not the origin of scrolling area. This simple and universal solution allows to restrict scrolling area with `CGRect`.

## Installation

Use `Swift Package Manager` to install.

## How To Use It

Can be created from code as usual:

```swift
override func viewDidLoad() {
        super.viewDidLoad()
        
        restrictedScrollView = EARestrictedScrollView(frame: view.bounds)
        restrictedScrollView.alwaysBounceVertical = true
        restrictedScrollView.alwaysBounceHorizontal = true
        view.addSubview(restrictedScrollView)
        
        let imageView = UIImageView(image: UIImage(named: "milky-way"))
        restrictedScrollView.addSubview(imageView)
        restrictedScrollView.contentSize = imageView.frame.size
    }
```

Or from Interface Builder:

![IB screenshot](Images/ScreenshotIB.png)

Update scrolling area with new `restrictionArea` property. Reset restriction with passing `CGRectZero` to `restrictionArea`.

```swift
func flipSwitch(sender: UISwitch) {
        if sender.on {
            restrictedScrollView.restrictionArea = sender.superview!.frame
        } else {
            restrictedScrollView.restrictionArea = CGRectZero
        }
    }
```

To access subviews use `containedSubviews` property.

```swift
let subviews = restrictedScrollView.containedSubviews
```

## Author

Created and maintained by Evgeny Aleksandrov ([@ealeksandrov](https://twitter.com/ealeksandrov)). Refactored and adapted for use with the `Swift Package Manager` by [Vitalis Gkirsas](https://github.com/epitonium).

## License

`EAIntroView` is distributed under the terms and conditions of the [MIT license](https://github.com/SVProgressHUD/SVProgressHUD/blob/master/LICENSE).
