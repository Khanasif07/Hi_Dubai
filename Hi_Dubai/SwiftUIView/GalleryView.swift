//
//  GalleryView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 01/06/2023.
//

import SwiftUI

struct GalleryView: View {
    @State var animals: [Animal] = Bundle.main.decode("animals.json")
    
    var animal: Animal?
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            Image(animal?.image ?? "")
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
            
//            Text(animal?.name ?? "")
//                .fontWeight(.heavy)
//                .background(.black)
//                .foregroundColor(.white)
//                .padding(5)
//                .offset(x: -5, y: -5)
//                .cornerRadius(5)
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static let animals: [Animal] = Bundle.main.decode("animals.json")
    static var previews: some View {
        GalleryView(animal: animals[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
