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
    
    let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            if #available(iOS 16.0, *) {
                List {
                    if videos.isEmpty{
                        ProgressView()
                    }else {
                        ForEach(videos) { item in
                            NavigationLink(destination: VideoPlayerView(videoSelected: item.id, videoTitle: item.name)) {
                                VideoListItemView(video: item)
                                    .padding(.vertical, 8)
                            }
                        }
                    }//: LOOP
                } //: LIST
                .scrollIndicators(.hidden)
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("Videos", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Shuffle videos
                            videos.shuffle()
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
      .previewDevice("iPhone 12 Pro")
  }
}

