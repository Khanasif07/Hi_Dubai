//
//  InsetGalleryView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 31/05/2023.
//

import SwiftUI

struct InsetGalleryView: View {
  // MARK: - PROPERTIES
  
  let animal: Animal
  
  // MARK: - BODY

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .center, spacing: 15) {
        ForEach(animal.gallery, id: \.self) { item in
            ZStack(alignment: .bottomTrailing){
                Image(item)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(12)
                
                Text(animal.name)
                    .fontWeight(.heavy)
                    .background(.black)
                    .foregroundColor(.white)
                    .padding(5)
                    .offset(x: -5, y: -5)
                    .cornerRadius(5)
//                    .clipShape(Capsule())
            }
        } //: LOOP
      } //: HSTACK
    } //: SCROLL
  }
}

// MARK: - PREVIEW

struct InsetGalleryView_Previews: PreviewProvider {
  static let animals: [Animal] = Bundle.main.decode("animals.json")
  
  static var previews: some View {
    InsetGalleryView(animal: animals[0])
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
