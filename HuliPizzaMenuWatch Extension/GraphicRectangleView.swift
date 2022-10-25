//
//  GraphicRectangleView.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Mitya Kim on 10/24/22.
//

import SwiftUI
import ClockKit

struct GraphicRectangleView: View {
    
    var stage: Int
    var stages = Stages()
    
    var body: some View {
        HStack {
            Text(stages.emoji(stage))
                .font(.largeTitle)
            
            VStack {
                Text("Pizza")
                
                Gauge(value: stages.fillFraction(stage: stage), in: 0...1) {
                    Text("")
                }
                .gaugeStyle(LinearGaugeStyle(tint: Gradient(colors: [.red, .yellow, .green])))
                Text(stages.text(stage))
                    .font(.caption)
            }
        }
    }
}

struct GraphicRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        
        CLKComplicationTemplateGraphicRectangularFullView(GraphicRectangleView(stage: 2))
            .previewContext()
       
    }
}
