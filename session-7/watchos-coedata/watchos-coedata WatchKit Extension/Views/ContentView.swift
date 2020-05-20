//
//  ContentView.swift
//  watchos-coedata WatchKit Extension
//
//  Created by T. Andrew Binkowski on 5/19/20.
//  Copyright © 2020 T. Andrew Binkowski. All rights reserved.
//

import SwiftUI

//
struct ContentView: View {
  var managedObjectContext = (WKExtension.shared().delegate as! ExtensionDelegate).persistentContainer.viewContext
  
  var body: some View {
    QuestionList().environment(\.managedObjectContext, managedObjectContext)
  }
}

//
struct QuestionList: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  @FetchRequest(entity: Question.entity(), sortDescriptors: [NSSortDescriptor(key: "question",
                                                   ascending: true)]) var questionList: FetchedResults<Question>
  
  var body: some View {
    ScrollView {
      ForEach(questionList, id: \.self) { question in
        Text("\(question.question ?? "something")")
          .font(.title)
          .fontWeight(.light)
      }
    }
  }
}


//
//
//
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
