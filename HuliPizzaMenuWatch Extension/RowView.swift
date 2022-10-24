//
//  RowView.swift
//  TestWatchAppSwiftUI
//
//  Created by Mitya Kim on 10/24/22.
//

import SwiftUI

struct RowView: View {
    
    var menuItem: MenuItem
    @State private var pizzaZoom: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image(String(format:"%i_100w",menuItem.id))
                .resizable()
                .frame(width: pizzaZoom ? 60 : 30,height: pizzaZoom ? 60 : 30)
                .onTapGesture {
                    pizzaZoom.toggle()
                }
                .animation(.interpolatingSpring(stiffness: 12, damping: 30))
                .scaledToFit()
                    .clipShape(Circle())
                Text(menuItem.name)
                    .font(.caption).fontWeight(.bold)
                    .minimumScaleFactor(0.85)
                Spacer()
            }
            Raitings(count: .constant(menuItem.rating))
                .frame(height: 12)
                .padding()
//            Text(menuItem.description)
//            Spacer()
        }
//        .animation(.easeInOut(duration: 0.75))
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(menuItem: MenuModel.menu[1])
    }
}
