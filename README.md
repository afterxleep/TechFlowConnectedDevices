# swiftSocketGyro
A quick example to learn how to use the deviceMotion hardware on iOS, and transmit its data in real time over the internet via websockets.

## Dependencies
This project requires the following dependencies.

- **[Starscream](https://github.com/daltoniam/Starscream)** (A conforming WebSocket (RFC 6455) client library in Swift.)

- **[CocoaPods](https://cocoapods.org)** (a dependency manager for Swift and Objective-C)

- **A Socket Server** (Sample provided in the repo)
  
     
## Setup/Start the Socket Server

A sample socket server written in ruby is provided in this example.  This server echoes back every message received, to start it.

```
cd server
gem install em-websocket
ruby server.rb
```


## Setting Up the iOS Project

* Make Sure you have the latest version of Xcode (9.4 or higher).

* Install CocoaPods by running this command on your teminal

```
sudo gem install cocoapods
```

* Install dependencies via CocoaPods, by running this command on your terminal (when in the project path)

```
cd swiftSocketGyro
pod install
```
 
* Open the swiftSocketGyro.xcworkspace project on Xcode 9

* Edit the server IP address 



**Note:**. Hardware Motion Sensors are not available on the iOS simulator.  You'll ned a real device to test this out.