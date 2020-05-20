//
//  ComplicationController.swift
//  2020-quiz-starter WatchKit Extension
//
//  Created by T. Andrew Binkowski on 5/19/20.
//  Copyright © 2020 T. Andrew Binkowski. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
  
  // MARK: - Timeline Configuration
  
  func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
    handler([])
  }
  
  func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
    handler(nil)
  }
  
  func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
    handler(nil)
  }
  
  func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
    handler(.showOnLockScreen)
  }
  
  // MARK: - Timeline Population
  
  func getCurrentTimelineEntry(for complication: CLKComplication,
                               withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
    
    let entry: CLKComplicationTimelineEntry
    
    switch complication.family {
      
    case .graphicCircular:
      let template = CLKComplicationTemplateGraphicCircularStackText()
      template.line1TextProvider = CLKSimpleTextProvider(text: "ABC")
      template.line2TextProvider = CLKSimpleTextProvider(text: "50")
      
      entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
      
    default:
      preconditionFailure("Complication family not supported")
    }
    
    handler(entry)
  }
  
  
  
  func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
    // Call the handler with the timeline entries prior to the given date
    handler(nil)
  }
  
  func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
    // Call the handler with the timeline entries after to the given date
    handler(nil)
  }
  
  // MARK: - Placeholder Templates
  
  func getLocalizableSampleTemplate(for complication: CLKComplication,
                                    withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
    // This method will be called once per supported complication, and the results will be cached
    switch complication.family {
      
    case .graphicCircular:
      let template = CLKComplicationTemplateGraphicCircularStackText()
      template.line1TextProvider = CLKSimpleTextProvider(text: "ABC")
      template.line2TextProvider = CLKSimpleTextProvider(text: "50")
      handler(template)
      
    default:
      preconditionFailure("Complication family not supported")
    }
  }
  
}



