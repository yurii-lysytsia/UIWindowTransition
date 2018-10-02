# UIWindowTransition

[![platform](https://img.shields.io/badge/Platform-iOS%208%2B-blue.svg)]()
[![language](https://img.shields.io/badge/Language-Swift%204.2-red.svg)]()
[![language](https://img.shields.io/badge/pods-available-green.svg)]()
[![license](https://img.shields.io/badge/license-MIT-lightgray.svg)]()

- [Requirements](#requirements)
- [Installation](#installation)
    - [CocoaPods](#CocoaPods)
    - [Manually](#Manually)
- [Usage](#usage)
- [License](#license)

## Requirements

- iOS 8.0+
- Xcode 10.0+
- Swift 4.2+

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
platform :ios, ‘8.0’

target '<Your Target Name>' do
    use_frameworks!
    pod 'UIWindowTransition'
end
```

- Then, run the following command:

```bash
$ pod install
```

- Finally, open your Xcode  `<Your Project Name>.xcworkspace`.

### Manually

- Download `UIWindowTransition` and copy file from `Source` folder into your project

## Usage

- First of all you have to import `UIWindowTransition`
```swift
import UIWindowTransition
```

- You have the opportunity to use several options to set root view controller. Choose which one suits you best.
```swift

// First of all you need get window. e.g:
let window = UIApplication.windows.first

// 1. Transition with UIWindow.Transition 
// After that you need create UIWindow.Transition and set custom parameters if you need.
var transition = UIWindow.Transition()
transition.style = .fromRight // Set custom transition animation.
transition.duration = 0.4 // Set custom transition duration in seconds.

// At the end you need create transition between view controllers and use one of that functions
window.transition(transition, to: newRootViewController)
// or 
UIApplication.shared.setRootViewController(newRootController, transition: transition)

// 2. Transition with UIWindow.TransitionStyle
// You can make transition between view controllers and use one of that functions
window.transition(to: newRootViewController, style: .fromRight)
// or 
UIApplication.shared.setRootViewController(newRootViewController, style: .fromRight)
```

## License
Released under the MIT license. See [LICENSE](https://github.com/YuriFox/UIWindowTransition/blob/master/LICENSE) for details.

