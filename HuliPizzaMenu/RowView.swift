//
//  RowView.swift
//  TestWatchAppSwiftUI
//
//  Created by Mitya Kim on 10/24/22.
//

import SwiftUI

struct RowView: View {
    var menuItem:MenuItem
    var body: some View {
        VStack {
            HStack {
                Image(String(format:"%i_100w",menuItem.id))
                .resizable()
                   .frame(width:60,height:60)
                .scaledToFit()
                    .clipShape(Circle())
                Text(menuItem.name)
                    .font(.largeTitle).fontWeight(.bold)
                    .minimumScaleFactor(0.85)
                Spacer()
            }
            Text(menuItem.description)
            Spacer()
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(menuItem: MenuModel.menu[1])
    }
}
