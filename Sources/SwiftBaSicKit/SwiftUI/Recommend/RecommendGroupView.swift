//
//  RecommendGroupView.swift
//  Follow-up
//
//  Created by Xiaowei Zhuang on 2022/6/10.
//

import SwiftUI

fileprivate extension UIImage {
    class func image(named: String) -> UIImage {
        return UIImage(named: named, in: .module, with: nil)!
    }
}

struct RecommendRow: View {
    var app: RecommendApp
    var cornerRadius: CGFloat = 10
    var body: some View {
        let item = app.data
        
        HStack(alignment: .top, spacing: 8) {
            Image(uiImage: .image(named: item.imageName))
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: .black.opacity(0.3), radius: 4, x: 4, y: 4)
                .shadow(color: .white.opacity(0.3), radius: 4, x: -4, y: -4)
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 12) {
                    Text(item.title, bundle: .module)
                        .font(.system(size: 14).bold())
                        .foregroundColor(.black.opacity(0.85))
                    if !item.isInstalled {
                        Text("Get")
                            .font(.system(size: 12))
                            .foregroundColor(.green)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 1)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.green.opacity(0.85))
                                    .background(
                                        Capsule()
                                            .foregroundColor(Color.green.opacity(0.15))
                                    )
                            )
                    }
                    else {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12).weight(.semibold))
                            .foregroundColor(.green)
                            .padding(4)
                            .background(
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.green)
                            )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 24)
//                .padding(.top)
                Text(item.content, bundle: .module)
                    .lineLimit(2)
                    .font(.system(size: 12))
                    .foregroundColor(.black.opacity(0.6))
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
        .frame(width: 300, alignment: .center)
        .background(LinearGradient(colors: [.gray.opacity(0.06), .white.opacity(0.75)],
                                   startPoint: .leading,
                                   endPoint: .trailing))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.white)
                .foregroundColor(item.backgroundColor.opacity(0.1))
                .shadow(color: .black.opacity(0.3), radius: 2, x: -2, y: -2)
                .shadow(color: .white, radius: 4, x: 2, y: 2)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        )
        .onTapGesture {
            if item.isInstalled {
                UIApplication.shared.open(item.scheme)
            }
            else {
                UIApplication.shared.open(item.url)
            }
        }
    }
}

public struct RecommendGroupView: View {
    public init() { }
    var allRecommendApps: [RecommendApp] = RecommendApp.allCases
    public var body: some View {
        ConfigSectionContainer {
            Text("Recommend.Developer", bundle: .module, comment: "开发者其它应用")
                .frame(maxWidth: .infinity, alignment: .leading)
            let rows = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 0) {
                    
                    ForEach(allRecommendApps) { recommendApp in
                        if recommendApp.data.bundleId != (Bundle.main.bundleIdentifier ?? "") {
                            RecommendRow(app: recommendApp)
                                .padding(.leading, 12)
                        }
                    }
                }
                .frame(height: 200)
            }
        }
//        .frame(height: 250)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
    }
}

struct RecommendGroupView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendGroupView()
//            .padding(.horizontal)
            .environment(\.locale, .init(identifier: "en"))
    }
}
