//
//  VideoListView.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 31/05/2023.
//

import SwiftUI

struct VideoListView: View {
    // MARK: - PROPERTIES
    @State var videos: [Video] = Bundle.main.decode("videos.json")
    @State var animals: [Animal] = Bundle.main.decode("animals.json")
    // Pagination
    @State private var isLoading: Bool = false
    @State private var page: Int = 0
    private let totalPage: Int = 3
    private let pageSize: Int = 10
    
    let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            if #available(iOS 16.0, *) {
                List(animals) { item in
                    VStack {
                        if animals.isEmpty{
                            ProgressView()
                        }else {
                            NavigationLink(destination: AnimalDetailView(animal: item)) {
                                AnimalListItemView(animal: item)
                                    .padding(.vertical, 8)
                            }
                        }
                        // Pagination Logic
                        if self.isLoading && self.animals.isLastItem(item) {
                            VStack{
                                Text("Loading...")
                                    .font(.headline)
                                    .foregroundColor(.accentColor)
                                ProgressView()
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .onAppear{
                        self.listItemAppears(item)
                    }
                    //: LOOP
                } //: LIST
                .scrollIndicators(.hidden)
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("Animals", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Shuffle videos
                            animals.shuffle()
                            hapticImpact.impactOccurred()
                        }) {
                            Image(systemName: "arrow.2.squarepath")
                        }
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        } //: NAVIGATION
    }
}

// MARK: - PREVIEW

struct VideoListView_Previews: PreviewProvider {
  static var previews: some View {
    VideoListView()
  }
}


// MARK: - listItemAppears
extension VideoListView {
    private func listItemAppears<Item: Identifiable>(_ item: Item) {
        if animals.isLastItem(item) && self.page < totalPage{
            isLoading = true
            /*
                Simulated async behaviour:
                Creates items for the next page and
                appends them to the list after a short delay
             */
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.page += 1
                let moreItems = animals
//                self.getMoreItems(forPage: self.page, pageSize: self.pageSize)
                self.animals.append(contentsOf: moreItems)
                self.isLoading = false
            }
        }
    }
}



// MARK: - Extension

extension RandomAccessCollection where Self.Element: Identifiable {
    public func isLastItem<Item: Identifiable>(_ item: Item) -> Bool {
        guard !isEmpty else {
            return false
        }
        
        guard let itemIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        
        let distance = self.distance(from: itemIndex, to: endIndex)
        return distance == 1
    }
    
}


