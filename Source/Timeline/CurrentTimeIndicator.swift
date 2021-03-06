import UIKit
import Neon

class CurrentTimeIndicator: UIView {

  var leftInset: CGFloat = 53

  var is24hClock = true {
    didSet {
      self.updateDate(date)
    }
  }

  var date = Date() {
    didSet {
      self.updateDate(date)
    }
  }

  fileprivate var timeLabel = UILabel()
  fileprivate var circle = UIView()
  fileprivate var line = UIView()

  var style = CurrentTimeIndicatorStyle()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }

  func configure() {
    [timeLabel, circle, line].forEach {
      addSubview($0)
    }
    updateStyle(style)
  }

  override func layoutSubviews() {
    let size = timeLabel.frame.size
    timeLabel.align(Align.toTheLeftCentered, relativeTo: line, padding: 5, width: size.width, height: size.height)

    line.frame = CGRect(x: leftInset - 5, y: bounds.height / 2, width: bounds.width, height: 1)

    circle.frame = CGRect(x: leftInset + 1, y: 0, width: 6, height: 6)
    circle.center.y = line.center.y
    circle.layer.cornerRadius = circle.bounds.height / 2
  }
  
  func updateDate(_ date: Date) {
    let dateFormat = is24hClock ? "HH:mm" : "h:mm a"
    timeLabel.text = date.format(with: dateFormat)
    timeLabel.sizeToFit()
    setNeedsLayout()
  }

  func updateStyle(_ newStyle: CurrentTimeIndicatorStyle) {
    style = newStyle.copy() as! CurrentTimeIndicatorStyle
    timeLabel.textColor = style.color
    timeLabel.font = style.font
    circle.backgroundColor = style.color
    line.backgroundColor = style.color
  }
}
