//
//  NotificationView.swift
//  2020-quiz-starter WatchKit Extension
//
//  Created by T. Andrew Binkowski on 5/19/20.
//  Copyright © 2020 T. Andrew Binkowski. All rights reserved.
//


import SwiftUI

struct NotificationView: View {
    let card: Card

    /*
     The NotificationView uses the same FlashCard as the CardList to show a
     flash card in an interactive notification.
     */
    var body: some View {
        VStack {
            Text("What's the answer?")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Divider()
            FlashCard(card: card)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(card: Card.previewCard)
    }
}
