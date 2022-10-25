//
//  DetailView.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Mitya Kim on 10/24/22.
//

import SwiftUI
import ClockKit

struct DetailView: View {
    
    var item: MenuItem
    @Binding var selectedItem: Int!
    @Binding var selectedRow: Int!
    @State private var isZooming = false
    @State private var isRatingPresented = false
    
    func reloadTimeLine() {
        now = Date()
        let server = CLKComplicationServer.sharedInstance()
        
        if let active = server.activeComplications {
            for complication in active {
                server.reloadTimeline(for: complication)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(item.name)
                        .fontWeight(.heavy)
                    Spacer()
                }
                Image("\(item.id)_100w")
                    .cornerRadius(10)
                    .onTapGesture {
                        self.isZooming.toggle()
                        WKInterfaceDevice.current().play(.click)
                    }
                    .sheet(isPresented: $isZooming) {
                        ZoomView(item: item)
                    }
//                Button {
//
//                    reloadTimeLine()
//
//                    WKInterfaceDevice.current().play(.success)
//                    self.selectedItem = self.item.id
//                    self.selectedRow = nil
//                } label: {
//                    Text("Order")
//                }
    //            ScrollView {
                OrderButton {
                    
                    reloadTimeLine()
                    
                    WKInterfaceDevice.current().play(.success)
                    self.selectedItem = self.item.id
                    self.selectedRow = nil
                } 
                    Text(item.description)
    //            }
                
//                NavigationLink(destination: RaitingsDetailView(item: item)) {
//                    Text("Raitings")
//                }
                Button {
                    self.isRatingPresented = true
                } label: {
                    Text("Raitings")
                }
                .sheet(isPresented: $isRatingPresented) {
                    RaitingsDetailView(item: item, isPresented: self.$isRatingPresented)
                }

            }.navigationTitle(item.name)
//                .fontWeight(.light)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: MenuModel.menu[2], selectedItem: .constant(2), selectedRow: .constant(2))
    }
}
