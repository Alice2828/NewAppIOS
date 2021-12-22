//
//  TopBarView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import SwiftUI

struct DetailsTopView: View {
    @ObservedObject var imageLoader: ImageLoader
    @Binding var offset: CGFloat?
    @Binding var initialOffset: CGFloat?
    let actionBack: () -> ()
    var article: Article
    @EnvironmentObject var likesViewModel: LikesViewModel
    @State var noUrl: Bool = false
    
    var imageToDisplay: Image {
        if likesViewModel.likesObservable.first(where: {$0.title == article.title}) != nil {
            return Image(systemName: "heart.fill")
        } else {
            return Image(systemName: "heart")
        }
    }
    
    var body: some View {
        VStack{
            HStack(spacing: 12) {
                //btn back
                Button(action: {
                    actionBack()
                }) {
                    ButtonImageInCircle(image:  Image(systemName: "arrow.backward"))
                }
                Spacer()
                
                //btn share
                Button(action: {
                    if let url = article.url{
                        actionSheet(url: url)
                    }
                    else {
                        noUrl = true
                    }
                }) {
                    ButtonImageInCircle(image:  Image(systemName: "square.and.arrow.up"))
                } .alert(isPresented: $noUrl) {
                    Alert(title: Text("There is no url to share"), message: Text("Try another article"), dismissButton: .cancel())
                }
                
                //btn like
                Button(action: {
                    likesViewModel.saveOrDeleteLike(article: article)
                }) {
                    ButtonImageInCircle(image:  imageToDisplay)
                }
                
            }
            .padding(.top, 35)
            .padding(.horizontal, 15)
            .padding(.bottom, 5)
            .background(viewForBackground())
            .animation(.linear)
        }
    }
    
    func actionSheet(url: String) {
            guard let data = URL(string: url) else { return }
            let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        }
    
    private func showTitleView() -> Bool {
        guard let initialOffset = initialOffset,
              let offset = offset else {
                  return true
              }
        
        if initialOffset > offset {
            return false
        }
        
        return true
    }
    
    private func viewForBackground() -> some View {
        let values = heightAndRadiusForBackground()
        return AnyView(RoundedRectangle(cornerRadius: values.1)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(UIColor.init(rgb:  0x81d5fa)), Color.purple]), startPoint: .top, endPoint: .bottom))
                        .frame(height: values.0)
                        .animation(.linear))
        
    }
    
    private func heightAndRadiusForBackground() -> (CGFloat, CGFloat, CGFloat) {
        let maxHeight: CGFloat = 350
        let minHeight: CGFloat = 127
        let factor: CGFloat = 5
        let radius: CGFloat = 60
        
        guard let initialOffset = initialOffset,
              let offset = offset else {
                  return (maxHeight, radius, maxHeight)
              }
        
        if initialOffset > offset {
            let diff = initialOffset - offset
            if diff > 20 {
                return (minHeight, 0, 0)
            } else {
                let computed = maxHeight - (factor * diff)
                let height = (computed > minHeight && computed < maxHeight) ? computed : minHeight
                let returnRadius = height == minHeight ? 0 : radius
                return (height, returnRadius, height)
            }
        }
        
        return (maxHeight, radius, minHeight)
    }
}
