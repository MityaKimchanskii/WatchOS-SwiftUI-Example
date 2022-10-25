//
//  ComplicationControllerExtension.swift
//  TestComplications WatchKit Extension
//
//  Created by Mitya Kim on 10/24/22.
//

import ClockKit
import SwiftUI

/// a static date for the beginning of a complication timeline. 
var now = Date(timeIntervalSince1970: 0)



extension ComplicationController{
    
    //MARK: - Complication providers
    func text(_ text: String) -> CLKSimpleTextProvider {
        return CLKSimpleTextProvider(text: text)
    }
    
    func pizzaStage(stage:Int)->CLKSimpleTextProvider{
        return CLKSimpleTextProvider(text: stages.text(stage))
    }
    func pizzaEmoji(stage:Int)->CLKSimpleTextProvider{
        return CLKSimpleTextProvider(text: stages.emoji(stage))
    }
    
    func estimatedTime(from date:Date) -> CLKRelativeDateTextProvider{
        return CLKRelativeDateTextProvider(date: date, relativeTo: date.addingTimeInterval(stages.totalTime), style: .timer, units: [.minute,.second])
    }
    
    // images -- Note due to a lot of images necessary for this, I am only using SF Symbols.
    func image(stage:Int) -> CLKImageProvider{
        return CLKImageProvider(onePieceImage: stages.symbol(stage) )
    }
    
    func colorImage(stage: Int) -> CLKFullColorImageProvider {
        return CLKFullColorImageProvider(fullColorImage: stages.symbol(stage), tintedImageProvider: image(stage: stage))
    }
    
    func ringGauge(stage: Int) -> CLKSimpleGaugeProvider {
        return CLKSimpleGaugeProvider(style: .ring, gaugeColor: .yellow, fillFraction: stages.fillFraction(stage: stage))
    }
    
    
    //All Families are represented here, but we are only using some for this demonstration.
    ///Creates the proper template for the complication, and populates it with data.
    //MARK: - Complication Templates
    func createComplicationTemplate(for complication:CLKComplication, stage:Int)-> CLKComplicationTemplate!{
        var template:CLKComplicationTemplate? = nil
        
        switch complication.family{
            //MARK: Circular Family
        case .circularSmall:
            template = nil
            //MARK: Modular Family
        case .modularLarge:
            template = nil
        case .modularSmall:
            template = nil
            //MARK:Utilitarian family
        case .utilitarianLarge:
            template = CLKComplicationTemplateUtilitarianLargeFlat(textProvider: pizzaStage(stage: stage),
                                                                   imageProvider: image(stage: stage))
        case .utilitarianSmall:
            template = CLKComplicationTemplateUtilitarianSmallRingImage(imageProvider: image(stage: stage),
                                                                        fillFraction: stages.fillFraction(stage: stage),
                                                                        ringStyle: .closed)
        case .utilitarianSmallFlat:
            template = CLKComplicationTemplateUtilitarianSmallFlat(textProvider: pizzaStage(stage: stage),
                                                                   imageProvider: image(stage: stage))
            //MARK:Extra large
            // this will default for any watch 3 if Graphcextralarge is used.
        case .extraLarge:
            template = nil
            //MARK:Graphic Family
        case .graphicExtraLarge:
            
            if complication.identifier == "custom" {
                // MARK: - CircularView
                template = CLKComplicationTemplateGraphicExtraLargeCircularView(XLargeCircularView(stage: stage))
            } else {
                // MARK: - GaugeView
                template = CLKComplicationTemplateGraphicExtraLargeCircularClosedGaugeView(gaugeProvider: ringGauge(stage: stage),
                                                                                           label: Text(stages.emoji(stage)))
            }
            
        case .graphicRectangular:
            
            if complication.identifier == "custom" {
                template = CLKComplicationTemplateGraphicRectangularFullView(GraphicRectangleView(stage: stage))
            } else {
                template = nil
            }
            
          
        case .graphicBezel:
            let gc = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText(gaugeProvider: ringGauge(stage: stage),
                                                                               bottomTextProvider: estimatedTime(from: now),
                                                                               centerTextProvider: pizzaEmoji(stage: stage))
            template = CLKComplicationTemplateGraphicBezelCircularText(circularTemplate: gc,
                                                                       textProvider: pizzaStage(stage: stage))
        case .graphicCircular:
            template = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText(gaugeProvider: ringGauge(stage: stage),
                                                                                 bottomTextProvider: estimatedTime(from: now),
                                                                                 centerTextProvider: pizzaEmoji(stage: stage))
        case .graphicCorner:
            template = CLKComplicationTemplateGraphicCornerGaugeText(gaugeProvider: ringGauge(stage: stage),
                                                                     leadingTextProvider: estimatedTime(from: now),
                                                                     trailingTextProvider: nil,
                                                                     outerTextProvider: pizzaEmoji(stage: stage))
        default:
            template = nil
            print("complication with raw value \(complication.family) not found")
            
        }
        return template
    }
    //MARK: - Complication Timelines
    func createTimeLineEntry(for complication:CLKComplication, date:Date,stage:Int)-> CLKComplicationTimelineEntry? {
        if let template = createComplicationTemplate(for: complication, stage: stage) {
            return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
        }
        return nil
    }
    
    func createOrderTimeline(for complication: CLKComplication)->[CLKComplicationTimelineEntry]?{
        var  timelineEntries:[CLKComplicationTimelineEntry]? = []
        
        for stage in 1..<stages.count {
            timelineEntries?.append(createTimeLineEntry(for: complication,
                                                        date: now.addingTimeInterval(stages.times(stage)),
                                                        stage: stage)!)
        }
        
        timelineEntries?.append(createTimeLineEntry(for: complication,
                                                    date: now.addingTimeInterval(stages.totalTime),
                                                    stage: 0)!)
        
        return timelineEntries
        
    }
    
}
