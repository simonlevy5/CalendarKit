![CalendarKit](https://cloud.githubusercontent.com/assets/8013017/22312394/aaf83e76-e368-11e6-8473-b3bcb4811803.png)
[![CI Status](http://img.shields.io/travis/richardtop/CalendarKit.svg?style=flat)](https://travis-ci.org/richardtop/CalendarKit)
[![Version](https://img.shields.io/cocoapods/v/CalendarKit.svg?style=flat)](http://cocoadocs.org/docsets/CalendarKit)
[![License](https://img.shields.io/cocoapods/l/CalendarKit.svg?style=flat)](http://cocoadocs.org/docsets/CalendarKit)
[![Platform](https://img.shields.io/cocoapods/p/CalendarKit.svg?style=flat)](http://cocoadocs.org/docsets/CalendarKit)

# CalendarKit
**CalendarKit** is a fully customizable calendar library written in Swift. It was designed to look similar to iOS Calendar app out-of-the-box, but allow complete customization when needed. To make modifications easy, CalendarKit is composed of multiple small modules. They can be used together, or on their own.

## Demo
You can try CalendarKit with CocoaPods. Just enter in Terminal:
```ruby
pod try CalendarKit
```
[Watch demo video](https://www.youtube.com/watch?v=jWM6EfGSCWc)

[Try it live in your browser](https://appetize.io/app/hauxptt044dype9jz4x3c4ka0c)



## Installation

**CalendarKit** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CalendarKit'
```

## Usage
Subclass DayViewController and implement `DayViewDataSource` protocol to show events.
CalendarKit requires `DayViewDataSource` to return an array of objects conforming to `EventDescriptor` protocol, specifying all the information needed to display a particular event:

```swift
// Return an array of EventDescriptors for particular date
override func eventsForDate(_ date: Date) -> [EventDescriptor] {
  var models = // Get events (models) from the storage / API

  var events = [Event]()

  for model in models {
      // Create new EventView
      let event = Event()
      // Specify TimePeriod
      let datePeriod = TimePeriod(beginning: model.beginning, end: model.start)
      event.datePeriod = datePeriod
      // Add info: event title, subtitle, location to the array of Strings
      var info = [model.title, model.location]
      info.append("\(datePeriod.beginning!.format(with: "HH:mm")) - \(datePeriod.end!.format(with: "HH:mm"))")
      // Set "text" value of event by formatting all the information needed for display
      event.text = info.reduce("", {$0 + $1 + "\n"})
      events.append(event)
  }

  return events
}
```
There is  no need to do layout, CalendarKit will take care of it. CalendarKit also creates `EventViews` for you and reuses them.

If needed, implement DayViewDelegate to handle user input

```swift
override func dayViewDidSelectEventView(_ eventview: EventView) {
  print("Event has been selected: \(eventview.data)")
}

override func dayViewDidLongPressEventView(_ eventView: EventView) {
  print("Event has been longPressed: \(eventView.data)")
}
```
## Localization
CalendarKit supports localization and uses iOS default locale to display month and day names. First day of the week is also selected according to iOS locale. Here are few examples:

<img src="https://cloud.githubusercontent.com/assets/8013017/22315259/bda72b46-e376-11e6-8d0b-20cb5fa2dc95.png" alt="Finnish" width="320">
<br>
<img src="https://cloud.githubusercontent.com/assets/8013017/22315567/8ba5f9c2-e378-11e6-860d-b94e87a2a45c.PNG" alt="German" width="320">
<br>
<img src="https://cloud.githubusercontent.com/assets/8013017/22315600/c87e826a-e378-11e6-9280-732982b42077.PNG" alt="Norwegian" width="320">

## Styles
CalendarKit's look can easily be customized. Just new `CalendarStyle` object to `DayView`'s `updateStyle` method:
```Swift
let style = CalendarStyle()
style.backgroundColor = UIColor.black
dayView.updateStyle(style)
```
<img src="https://cloud.githubusercontent.com/assets/8013017/22717896/a2a6c6f2-edae-11e6-8ac3-d9add3d61fb9.png" alt="Light theme" width="320"> <img src="https://cloud.githubusercontent.com/assets/8013017/22717895/a2a63a66-edae-11e6-8611-727348598f09.png" alt="Dark theme" width="320"> 

## Requirements

- iOS 9.0+
- Swift 3.0+

## Dependencies
- **[Neon](https://github.com/mamaral/Neon)** is used for declarative layout
- **[DateTools](https://github.com/MatthewYork/DateTools)** is used for date manipulation

## Roadmap
CalendarKit is under development, API can and will be changed.
- [ ] Improve customization
- [ ] Landscape support
- [ ] Add to Carthage
- [ ] Documentation

## Author

Richard Topchii

## License

**CalendarKit** is available under the MIT license. See the LICENSE file for more info.
