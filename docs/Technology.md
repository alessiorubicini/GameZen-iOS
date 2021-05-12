# GameZen's technology

## Table of contents
- [Context](#context)
- [Architecture](#architecture)
- [iOS client](#iOS-client)
- [Backend Services](#backend-services)


## Context
This document provides a low-level design description of the technology developed for GameZen iOS.

## Architecture
GameZen’s architecture includes iOS Client and Backend Services.

**Mobile client**: the user’s mobile device and all the software running on it. Within the context of GameZen, its core functions include the following:
- User authentication for already registered users
- User registration for new users
- Catalog consultation
- Cart management for saving products
- Sending and tracking orders
- Delivery addresses management

**Backend services**: GameZen’s backend software and infrastructure.

## iOS client

The iOS App is available for devices running at least iOS 14.0. 

The App is written using Swift 5.5 and Xcode 12.3.

The development process leverages the following technologies:
- **[CocoaPods](https://cocoapods.org/).** The most widespread dependency manager in the iOS community, CocoaPods is released as an open-source project under the MIT licence.
- **[Fastlane](https://fastlane.tools/).** An open-source tool suite to automate releases and deployments for apps. Fastlane is released as an open-source project under MIT license.

When it comes to the iOS App’s architecture, GameZen relies on Apple's native framework [SwiftUI](https://developer.apple.com/xcode/swiftui/), an innovative, exceptionally simple way to build user interfaces across all Apple platforms with the power of Swift.

GameZen leverages other open-source libraries, including:
- **[Alamofire](https://github.com/Alamofire/Alamofire).** The de-facto standard for performing HTTP requests on iOS, Alamofire is released as an open-source project under the MIT licence.
- **[SwiftUIX](https://github.com/SwiftUIX/SwiftUIX).** A SwiftUI library that provides additional components for creating the user interface. SwiftUIX is released as an open-source project under MIT license.
- **[SwiftUIComponents](https://github.com/alessiorubiciniSwiftUI-Components).** A package containing both backend and frontend useful components for iOS development with SwiftUI. SwiftUIComponents is released as an open-source project under MIT license.
- **[StatusAlert](https://github.com/LowKostKustomz/StatusAlert).** An iOS framework that displays status alerts similar to Apple's system self-hiding alerts. It is well suited for notifying user without interrupting user flow in iOS-like way. StatusAlert is released as an open-source project under MIT license.


## Backend services



