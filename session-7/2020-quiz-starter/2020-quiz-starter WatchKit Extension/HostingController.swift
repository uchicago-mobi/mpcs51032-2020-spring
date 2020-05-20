//
//  HostingController.swift
//  2020-quiz-starter WatchKit Extension
//
//  Created by T. Andrew Binkowski on 5/19/20.
//  Copyright © 2020 T. Andrew Binkowski. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<TopicList> {
    override var body: TopicList {
        // Show the topic list using our Flash Card model.
        TopicList(model: FlashCardModel())
    }
  
  struct HostingController_Previews: PreviewProvider {
    static var previews: some View {
      /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
  }

}
