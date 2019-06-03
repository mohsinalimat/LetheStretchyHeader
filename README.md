# LetheStretchyHeader
![LetheStretchyHeader](LetheStretchyHeader.gif)




Installation
------------

### CocoaPods

Just add `pod 'LetheStretchyHeader'` to your Podfile then run `pod install` or `pod update`.

In any file you'd like to use LetheStretchyHeader in, don't forget to
import the framework with `import LetheStretchyHeader`.

### Manually
Download and drop LetheStretchyHeader.swift in your project.


Usage
---

```swift
   LetheStretchyHeader().initial(viewController: self,
                                      parentView: scrollView,
                                      customHeader: nil,
                                      image: UIImage(named: "sample"),
                                      height: 200,
                                      type: .afterShowNavigationBar)
```                                
                                      
you can select one of the types
  
  ```swift
  public enum HeaderType {
    case afterShowNavigationBar
    case alwaysHideNavigationBar
    case alwaysShowNavigationBar
}
```

License
-------

LetheStretchyHeader is released under an MIT license. See ``LICENSE`` for more information.
