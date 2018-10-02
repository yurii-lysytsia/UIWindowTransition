# UIWindowTransition

[![platform](https://img.shields.io/badge/Platform-iOS%208%2B-blue.svg)]()
[![language](https://img.shields.io/badge/Language-Swift-red.svg)]()
[![language](https://img.shields.io/badge/pod-4.0.0-blue.svg)]()
[![license](https://img.shields.io/badge/license-MIT-lightgray.svg)]()

UIWindowTransition is easy to use source for change UIWindow RootViewController with animation. UIWindowTransition written in Swift 4.0.

!!! ATTENTION !!! 
The documentation is not accurate because the sources are updated.

- [Requirements](#requirements)
- [Installation](#installation)
    - [CocoaPods](#CocoaPods)
    - [Manually](#Manually)
- [Usage](#usage)
- [License](#license)

## Requirements

- iOS 8.0+
- Xcode 9.0+
- Swift 4.0+

## Installation
### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

- Create `Podfile` into your Xcode project. Open up `Terminal` → `cd` into your project's top-level directory → Run the following command:

```bash
$ pod init
```

- Open up created  `Podfile`.

```bash
$ open Podfile
```

- In the `Podfile` that appears, specify. Instead of `<Your Target Name>`, enter your project's name :

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, ‘8.0’

target '<Your Target Name>' do
    use_frameworks!
    pod 'UIWindowTransition'
end
```

- Then, run the following command:

```bash
$ pod update
$ pod install
```

- Finally, open your Xcode  `<Your Target Name>.xcworkspace`.

### Manually

- Download `UIWindowTransition` and copy all files from `Source` folder into your project

## Usage

- First of all you have to import `UIWindowTransition`
```swift
import UIWindowTransition
```

- After that you need get UIWindow
```swift
// Window which need set root view controller.
// e.g.
let window = UIApplication.shared.windows.first
```

- Create Animation options if need
```swift
/*
Animation for UIWindow transition:
- Fade: center -> center (animated change alpha)
- zoom(scale): center -> center (scale from `scale` to 1.0)
- toTop: bottom -> top
- toBottom: top -> bottom
- toLeft: right -> left
- toRight: left -> right
*/
let animation: UIWindowTransitionOptions.Transition

// You can create options if you would like animated set root view controller.
var options = UIWindowTransitionOptions(transition: animation)
options.duration = 0.4 // Set custom duration in seconds if need. Default is 0.25s
options.curve = .easeIn // Set custom curve if need. Default is linear
```

- Set new root view controller
```swift
/*
controller - new rootViewController
transitionOptions - options for transition. If you put `nil`, viewController will change without animation
*/
window.setRootViewController(someController, transitionOptions: options)
```

## License
Released under the MIT license. See [LICENSE](https://github.com/YuriFox/YFKeychainAccess/blob/1.0/LICENSE) for details.

