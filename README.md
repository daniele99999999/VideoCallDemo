
# # VideoCallDemo

## Description
This is a proposed solution for a CodeChallenge related to build a simple iOS app enabling authenticated users to make video calls to contacts saved in their address book.

These are Guidelines & Requirements:
1. The app must support all iOS versions starting from iOS 10 up to the latest one (iOS 15)
2. The app must run both on physical and simulated devices
3. The app must run on iPhones and iPads

## Architecture
The architecture implemented it's built on MVVM + Coordinator.
Every screen Its built around a ViewModel and a ViewController, with all the UI managed by a custom UIView attacched to the root of UIViewController. The Coordinator is responbile for navigation between ViewControllers. Because of there are no api provided for manage the network stack, all network code are mocked with some reasonable ocjects mock. A fake token is saved and persisted inside the keychain.
There are 4 screens: 
- Root, with login/logout/contact list buttons
- Login, for manage a fake login with user/password
- Contact List, with a selectable list of contacts up to 4, to pass in the Call screen
- Call, for manage the actual Video call from 1to1 till 1to4 contacts. There is a preview camera layer avaiable while targeting on a physical device

Every component it's built with protocols and dependency injection, for make every piece of logic more reliable and testable.
Because of lack of experience with reactive programming, the current implementation of MVVM it's built around closures, to mimic the behaivor of reactive frameworks. There are Unit Tests for viewmodels and services. The app it's currently fully usable online, beacuse of the remote jpg urls used inside mocks.

## Notes
I used two external libraries managed by SPM:
- Kingfisher: a powerful library for asynchronous image downloading and caching. Used by imageview category for download and cancel remote images inside the app
- KeyChainAccess: a simple Swift wrapper for Keychain that works on iOS and OS X. Used by the AuthDataService for Token persistence

The Unit Test coverage its not as good as possible due lack of time. Anyway i managed to test the main behaivor of the various layers, and the RootViewModel. The netwokr components are already there and ready to use for a real network stack.
I had to relax the iOS 10 minimum version and target on ios11, because of xcode 13.x doesnt support ios10 simulator anymore, so make sense to not write code that cannot be tested during development process

## Requirements
Target SDK 11
Developed on Xcode 13.1

## Installation & Execution
There are external dependencies (CryptoSwift, GRDB, Kingfisher) managed by SPM, so no installation it's required: open the project and run.

## Author
Daniele99999999

## License
SuperHeroSquadMaker it's available under MIT License. See LICENSE file for more information
