import UIKit
import AVFoundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let string = "One fish Two fish Red fish Blue fish. Black fish Blue fish Old fish New; fish. This one has a little star. This one has a little car. Say! What a lot of fish there are;"

let synthesizer = AVSpeechSynthesizer()
synthesizer.stopSpeaking(at: .word)
let voice = AVSpeechSynthesisVoice(language: "en_US")
let utterance = AVSpeechUtterance(string: string)
utterance.voice = voice

utterance.pitchMultiplier = 1.0
utterance.rate = 1.0

synthesizer.speak(utterance)
