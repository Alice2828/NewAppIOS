//
//  TopBarView.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import SwiftUI

struct TopView: View {
    @ObservedObject var imageLoader: ImageLoader
    @Binding var offset: CGFloat?
    @Binding var initialOffset: CGFloat?
    let actionBack: () -> ()
    var article: Article
    @EnvironmentObject var likesViewModel: LikesViewModel
    
    var imageToDisplay: Image {
        if likesViewModel.likesObservable.first(where: {$0.title == article.title}) != nil {
            print("HIHIHI \(likesViewModel.likesObservable)")
            return Image(systemName: "heart.fill")
        } else {
            return Image(systemName: "heart")
        }
    }
    @State var noUrl: Bool = false
    
    
    var body: some View {
        VStack{
            HStack(spacing: 12) {
                Button(action: {
                    actionBack()
                }) {
                    ButtonImageInCircle(image:  Image(systemName: "arrow.backward"))
                }
                Spacer()
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
                        .fill(LinearGradient(gradient: Gradient(colors: [Color("navTitle1"), Color.purple]), startPoint: .top, endPoint: .bottom))
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
    
    struct ButtonImageInCircle: View{
        var image: Image
        var body: some View {
            image
                .renderingMode(.original)
                .foregroundColor(Color("navTitle1"))
                .font(.system(size: 16, weight: .medium))
                .frame(width: 36, height: 36)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
        }
    }
    
}


struct TitleView: View {
    
    let title: String
    let imageName: String
    var foregroundColor: Color = Color("navTitle1")
    
    var body: some View {
        HStack(spacing: 12) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(foregroundColor)
                .frame(width: 16, height: 16)
                .padding(.leading, 24)
            Text(title)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(foregroundColor)
            Spacer()
        }
    }
    
}
