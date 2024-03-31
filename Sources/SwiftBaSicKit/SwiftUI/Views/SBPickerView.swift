//
//  SBPickerView.swift
//
//
//  Created by Xiaowei Zhuang on 2024/3/31.
//

import SwiftUI
import AudioToolbox

struct SBPickerConfig {
    var rowHeight: CGFloat = 50
    var pickerWidth: CGFloat = 300
    var pickerHeight: CGFloat = 200
    var backgroundColor: Color = .white
    
    var coverBackground: Color = .orange
    var coverCorner: CGFloat = 14
    var coverTextColor: Color = .white
}

struct SBPicker<PickerItem: Identifiable, RowContent: View, OverlayContent: View>: View {
    @Binding var index: Int
    let items: [PickerItem]
    var config: SBPickerConfig = SBPickerConfig()
    let rowContent: (_ item: PickerItem, _ index: Int) -> RowContent
    var overlayContent: (_ item: PickerItem) -> OverlayContent
    var body: some View {
        SBPickerView(pickerCount: items.count,
                         index: $index,
                         rowHeight: config.rowHeight,
                         width: config.pickerWidth,
                         height: config.pickerHeight) {
            VStack(spacing: 0) {
                ForEach(0..<items.count, id: \.self) { index in
                    rowContent(items[index], index)
                        .frame(maxWidth: .infinity)
                        .frame(height: config.rowHeight)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: config.pickerWidth, height: config.pickerHeight)
        .overlay(
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(.clear)
                    .overlay(LinearGradient(colors: [config.backgroundColor.opacity(0.2),
                                                     config.backgroundColor.opacity(0.5),
                                                     config.backgroundColor.opacity(0.8)],
                                                    startPoint: .bottom,
                                                    endPoint: .top))
                overlayContent(items[index])
                    .font(.system(size: 24).bold())
                    .foregroundColor(config.coverTextColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: config.rowHeight)
                    .background(
                        RoundedRectangle(cornerRadius: config.coverCorner)
                            .foregroundColor(config.coverBackground)
                    )
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(colors: [config.backgroundColor.opacity(0.2),
                                                        config.backgroundColor.opacity(0.5),
                                                        config.backgroundColor.opacity(0.8)],
                                                    startPoint: .top,
                                                    endPoint: .bottom))
            }
            .allowsHitTesting(false)
        )
        .clipped()
    }
}

struct SBPickerView<Content: View>: UIViewRepresentable {
    
    @Binding var index: Int
    var content: Content
    var pickerCount: Int
    var rowHeight: CGFloat = 50
    let width: CGFloat
    let height: CGFloat
    init(pickerCount: Int,
         index: Binding<Int>,
         rowHeight: CGFloat,
         width: CGFloat,
         height: CGFloat,
         @ViewBuilder content: @escaping () -> Content) {
        self.pickerCount = pickerCount
        self._index = index
        self.rowHeight = rowHeight
        self.width = width
        self.height = height
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        
        let swiftUIView = UIHostingController(rootView: content).view!
        let height = CGFloat(pickerCount) * rowHeight
        swiftUIView.frame = .init(x: 0, y: 0, width: width, height: height)
        swiftUIView.backgroundColor = .clear
        
        let inset = (self.height - rowHeight) / 2
        scrollView.contentSize = swiftUIView.frame.size
        scrollView.contentInset = .init(top: inset, left: 0, bottom: inset, right: 0)
        scrollView.addSubview(swiftUIView)
//        scrollView.bounces = false
        scrollView.delegate = context.coordinator
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.setContentOffset(.init(x: 0, y: CGFloat(index) * rowHeight - inset), animated: false)
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        let offset = uiView.contentOffset.y + uiView.contentInset.top
        let curIndex = Int((offset / rowHeight).rounded(.toNearestOrAwayFromZero))
        if curIndex != index {
            uiView.setContentOffset(.init(x: 0, y: CGFloat(index) * rowHeight - uiView.contentInset.top), animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: SBPickerView
        
        init(parent: SBPickerView) {
            self.parent = parent
        }
        
        private func calculateIndex(_ offset: CGPoint, inset: UIEdgeInsets) -> Int {
            let offset = offset.y + inset.top
            var newIndex = Int((offset / parent.rowHeight).rounded(.toNearestOrAwayFromZero))
            newIndex = min(max(newIndex, 0), parent.pickerCount - 1)
            
            return newIndex
        }
        
        private func playSound() {
            AudioServicesPlayAlertSound(kAudioServicesPropertyIsUISound)
            AudioServicesPlaySystemSound(1157)
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let newIndex = calculateIndex(scrollView.contentOffset, inset: scrollView.contentInset)
            if newIndex != parent.index {
                parent.index = newIndex
                playSound()
            }
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let newIndex = calculateIndex(scrollView.contentOffset, inset: scrollView.contentInset)
            if newIndex != parent.index {
                scrollView.setContentOffset(.init(x: 0, y: CGFloat(newIndex) * parent.rowHeight - scrollView.contentInset.top), animated: false)
                
                playSound()
            }
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            /// 如果scrollViewDidEndDecelerating没有调用
            if !decelerate {
                let newIndex = calculateIndex(scrollView.contentOffset, inset: scrollView.contentInset)
                let targetY = CGFloat(newIndex) * parent.rowHeight - scrollView.contentInset.top
                scrollView.setContentOffset(.init(x: 0, y: targetY), animated: false)
            }
        }
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            let targetOffset = targetContentOffset.pointee.y + scrollView.contentInset.top
            var partialRow = Int((targetOffset / parent.rowHeight).rounded(.toNearestOrAwayFromZero))
            if partialRow < 0 {
                partialRow = 0
            }
            else {
                targetContentOffset.pointee.y = CGFloat(partialRow) * parent.rowHeight - scrollView.contentInset.top
            }
            parent.index = partialRow
        }
    }
}

extension Int: Identifiable {
    public var id: Int { self }
}
#Preview {
    StatefulPreviewWrapper(0) { value in
        SBPicker(index: value,
                 items: (1...10).map({ $0 }),
                 config: SBPickerConfig()) { item, index in
            HStack {
                Text("\(item)")
                    .font(.system(size: 20).bold())
                    .foregroundColor(.black)
                Image(systemName: "flame.fill")
                    .font(.system(size: 20).bold())
                    .opacity(0)
            }
            .frame(height: 50)
        } overlayContent: { item in
            HStack {
                Text("\(item)")
                    .font(.system(size: 20).bold())
                Image(systemName: "flame.fill")
                    .font(.system(size: 20).bold())
            }
        }
    }
}
