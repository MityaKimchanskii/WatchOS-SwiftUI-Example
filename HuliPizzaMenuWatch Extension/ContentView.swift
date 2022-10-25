//
//  ContentView.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Mitya Kim on 10/24/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Pizza")
                .fontWeight(.bold)
                .foregroundColor(Color.green)
            Divider()
            PizzaOrderView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
