//
//  XLargeCircularView.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Mitya Kim on 10/24/22.
//

import SwiftUI
import ClockKit

struct XLargeCircularView: View {
    var stage:Int
    var stages = Stages()
    var colors:[Color] = [.clear,.red,.yellow,.green,.blue]
    var body: some View {
        VStack {
            
            // MARK: - GaugeView
            Gauge(value: stages.fillFraction(stage: stage), in: 0...1) {
                Text("Pizza")
            } currentValueLabel: {
                Text(stages.emoji(stage))
            } minimumValueLabel: {
                Text(stages.emoji(0))
            } maximumValueLabel: {
                Text(stages.emoji(4))
            }
            .gaugeStyle(CircularGaugeStyle(tint: Gradient(colors: colors)))
            
            Spacer()
            
            // MARK: - CircularView
//            ProgressView(value: stages.fillFraction(stage: stage)) {
//                Text(stages.emoji(stage))
//            }
//
//            .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
            
            HStack{
                Spacer()
                
                Text(stages.text(stage))
                .font(.callout)
                
                Spacer()
            }
            Spacer()
        }
//        .background(Color.gray)
    }
}

struct XLargeCircularView_Previews: PreviewProvider {
    static var previews: some View {
        XLargeCircularView(stage:2)
        CLKComplicationTemplateGraphicExtraLargeCircularView( XLargeCircularView(stage:2))
            .previewContext()
    }
}
