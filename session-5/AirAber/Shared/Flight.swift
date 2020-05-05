/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#if !os(iOS)
import WatchKit
#endif
import UIKit

class Flight {
  
  let origin: String
  let destination: String
  let number: String
  let boardsAt: String
  fileprivate let delayed: String

  var onSchedule: Bool {
    get {
      return delayed == "no"
    }
  }

  let gate: String
  let seat: String
  var route: String {
    get {
      return "\(origin) to \(destination)"
    }
  }

  let letters = 2
  var shortNumber: String {
    get {
      return String(number.dropFirst(letters))
    }
  }

  var checkedIn = false
  var boardingPass: UIImage?
  var reference: String {
    get {
      return "\(origin):\(destination):\(number):\(seat)"
    }
  }

  class func allFlights() -> [Flight] {
    var flights: [Flight] = []
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"

    guard let path = Bundle.main.path(forResource: "Flights", ofType: "json"),
      let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
        return flights
    }

    do {
      let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: String]]
      json.forEach({ (dict: [String: String]) in
        flights.append(Flight(dictionary: dict, formatter: formatter))
      })
    } catch let error as NSError {
      print(error)
    }

    return flights
  }

  init(origin: String, destination: String, number: String, boardsAt: String, delayed: String, gate: String, seat: String) {
    self.origin = origin
    self.destination = destination
    self.number = number
    self.boardsAt = boardsAt
    self.delayed = delayed
    self.gate = gate
    self.seat = seat
  }

  convenience init(dictionary: [String: String], formatter: DateFormatter) {
    let origin = dictionary["origin"]!
    let destination = dictionary["destination"]!
    let number = dictionary["number"]!
    let boardsAt = formatter.string(from: Date().addingTimeInterval(Double(arc4random_uniform(21600) + 1800)))
    let delayed = dictionary["delayed"]!
    let gate = dictionary["gate"]!
    let row = ["A", "B", "C", "D", "E", "F", "G"]
    let seat = "\(arc4random_uniform(40) + 1)\(row[Int(arc4random_uniform(UInt32(row.count)))])"
    self.init(origin: origin, destination: destination, number: number, boardsAt: boardsAt, delayed: delayed, gate: gate, seat: seat)
  }
}
