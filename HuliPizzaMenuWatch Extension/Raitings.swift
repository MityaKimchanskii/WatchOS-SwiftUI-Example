//
//  Raitings.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Mitya Kim on 10/24/22.
//

import SwiftUI

struct Raitings: View {
    
    @Binding var count: Int
    var maxStars: Int = 6
    
    var body: some View {
        HStack {
            ForEach(1...maxStars, id: \.self) { star in
                Image(systemName: star > self.count ? "star" : "star.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct Raitings_Previews: PreviewProvider {
    static var previews: some View {
        Raitings(count: .constant(3))
    }
}
