//  SideNavView.swift
import SwiftUI

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowingSideNav: Bool
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                if isShowingSideNav {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isShowingSideNav = false
                            }
                        }
                }

                VStack {
                    ScrollView {
                        SideNavContent(isShowingSideNav: $isShowingSideNav)
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width * 0.85)
                .background(.white)
                .offset(x: isShowingSideNav ? max(dragOffset, -geometry.size.width) : -geometry.size.width)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.width < 0 {
                                dragOffset = value.translation.width
                            }
                        }
                        .onEnded { value in
                            if value.translation.width < -geometry.size.width * 0.25 {
                                withAnimation {
                                    isShowingSideNav = false
                                }
                            }
                            dragOffset = 0
                        }
                )
                .animation(.easeInOut, value: isShowingSideNav)
                .animation(.easeInOut, value: dragOffset)
            }
        }
        .toolbar(isShowingSideNav ? .hidden : .visible, for: .navigationBar)
    }
}



#Preview {
    SideMenuView(isShowingSideNav: Binding<Bool>.constant(true))
}


struct SideNavContent: View {
    @Binding var isShowingSideNav: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Button {
                isShowingSideNav.toggle()
            } label: {
                Image(systemName: "arrowshape.backward")
            }
            .accessibilityLabel("dismiss")
            
            Button("Home", systemImage: "house") {
                isShowingSideNav.toggle()
            }
            
            Button("Profile", systemImage: "person") {
                isShowingSideNav.toggle()
            }
            
            Button("Settings", systemImage: "gear") {
                isShowingSideNav.toggle()
            }
            
            Button("Friends", systemImage: "person.3") {
                isShowingSideNav.toggle()
            }
            
            Button("Notifications", systemImage: "bell") {
                isShowingSideNav.toggle()
            }
            
            Button("Share", systemImage: "square.and.arrow.up") {
                isShowingSideNav.toggle()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 16)
    }
}
