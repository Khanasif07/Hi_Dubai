//
//  TabGalleryView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 01/06/2023.
//

import SwiftUI

struct TabGalleryView: View {

  @State var animals: [Animal] = Bundle.main.decode("animals.json")
    
  var body: some View {
    TabView {
      ForEach(animals) { animal in
          GalleryView(animal: animal)
              .padding(.horizontal, 15)
      }
    } //: TAB
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
  }
}

struct TabGalleryView_Previews: PreviewProvider {
  static var previews: some View {
      TabGalleryView()
          .previewDevice("iPhone 13")
          .background(Color.gray)
  }
}
