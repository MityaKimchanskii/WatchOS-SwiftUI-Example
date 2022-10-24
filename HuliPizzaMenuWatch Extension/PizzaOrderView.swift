//
//  PizzaOrderView.swift
//  PizzaOrder
//
//  Created by Mitya Kim on 10/24/22.
//

import SwiftUI

struct PizzaOrderView: View {
    @State var selectedItem:Int!
    @State var selectedRow:Int!
    var menuItems = MenuModel.menu
    var body: some View {
        GeometryReader{ geometry in
        VStack {
             Text(self.selectedItem != nil ? MenuModel.menu[self.selectedItem!].name :"Pick a Pizza")
                .font(.body)
            List{
                ForEach(self.menuItems){ item in
                    NavigationLink(destination: DetailView(item: item,
                                                           selectedItem: self.$selectedItem,
                                                           selectedRow: self.$selectedRow),
                                   tag: item.id,
                                   selection: self.$selectedRow
                    ) {
                        RowView(menuItem: item)
                            .animation(.interpolatingSpring(stiffness: 12, damping: 30))
                    }
                   
//                        .onTapGesture {
//                            self.selectedItem = item.id
//                    }// tapGesture
                    .listRowPlatterColor(Color(red: 0, green: (self.selectedItem == item.id ? 0.5 : 0.2), blue: 0))
                }//foreach
                  
                
            }//list
            .listStyle(CarouselListStyle())
            
            
        }//Vstack
        }//GeometryReader
    }
}

struct PizzaOrderView_Previews: PreviewProvider {
    static var previews: some View {
        PizzaOrderView()
    }
}
