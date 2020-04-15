import Foundation

@objc
public class EventListener: NSObject {
 @objc
  public var eventFired: (() -> ())?
  @objc
  public func handleEvent() {
    eventFired?()
  }
}
