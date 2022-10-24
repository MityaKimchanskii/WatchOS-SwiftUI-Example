//
//  ContentView.swift
//  HuliPizzaMenu
//
//  Created by Mitya Kim on 10/24/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Huli Pizza Company")
                .font(.headline)
            PizzaOrderView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
