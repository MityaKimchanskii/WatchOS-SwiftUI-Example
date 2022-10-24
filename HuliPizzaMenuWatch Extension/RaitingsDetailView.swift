//
//  RaitingsDetailView.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Mitya Kim on 10/24/22.
//

import SwiftUI

struct RaitingsDetailView: View {
    
    var item: MenuItem
    @Binding var isPresented: Bool
    @State var myRaiting: Float = 0
    
    var body: some View {
        VStack {
            Text("\(myRaiting)")
            Raitings(count: .constant(Int(myRaiting)))
            Image("\(item.id)_100w")
                .resizable()
                .scaledToFit()
            Button {
                self.isPresented = false
            } label: {
                Text("Okay")
            }

        }
        .navigationTitle(item.name)
        .focusable(true)
        .digitalCrownRotation($myRaiting,
                              from: 0,
                              through: 6,
                              by: 1,
                              sensitivity: .low,
                              isContinuous: false,
                              isHapticFeedbackEnabled: true)
    }
}

struct RaitingsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RaitingsDetailView(item: MenuModel.menu[7], isPresented: .constant(true))
    }
}
