//
//  MainView.swift
//  SideSlideMenu
//
//  Created by Jay Song on 2022/6/10.
//

import SwiftUI

struct MainView: View {
    @State private var showMenu: Bool = false
    
    // Offset for both drag gesture and showing menu
    @State var offset: CGFloat
    @State var lastStoredOffset: CGFloat
    
    // Gesture offset
    @GestureState var gestureOffset: CGFloat = 0
    
    let sideBarWidth = UIScreen.main.bounds.width - 90
    
    init() {
        offset = -sideBarWidth
        lastStoredOffset = -sideBarWidth
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Main Tab View
                VStack(spacing: 0) {
                    HomeView(showMenu: $showMenu)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                        .tag("Home")
                }
                .frame(width: getMainRect().width)
                
                // Side menu
                SideMenuView(showMenu: $showMenu, sideBarWidth: sideBarWidth)
                    .offset(x: offset >= 0 ? 0 : offset)
            }
            .overlay(
                Rectangle()
                    .fill(
                        Color.primary.opacity(Double((1 - (abs(offset) / sideBarWidth)) / 5))
                    )
                    .ignoresSafeArea(.container, edges: .vertical)
                    .onTapGesture {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }
            )
        }
        .gesture(
            DragGesture()
                .updating($gestureOffset, body: { value, out, _ in
                    out = value.translation.width
                })
                .onEnded { value in
                    onEnd(value: value)
                }
        )
        
        // Hide nav bar
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .animation(.easeOut(duration: 0.3), value: offset == -sideBarWidth)
        .onChange(of: showMenu) { _ in
            if showMenu, offset == -sideBarWidth {
                offset = 0
                lastStoredOffset = offset
            }
            
            if !showMenu, offset == 0 {
                offset = -sideBarWidth
                lastStoredOffset = -sideBarWidth
            }
        }
        .onChange(of: gestureOffset) { _ in
            onChange()
        }
    }
    
    func onChange() {
        offset = gestureOffset + lastStoredOffset
    }
    
    func onEnd(value: DragGesture.Value) {
        let translation = value.translation.width
        
        withAnimation(.easeOut(duration: 0.3)) {
            // Checking
            if translation > 0 {
                if translation > (sideBarWidth / 3) {
                    offset = 0
                    showMenu = true
                } else {
                    if abs(offset) < (sideBarWidth / 2) {
                        return
                    }
                    
                    offset = -sideBarWidth
                    showMenu = false
                }
            } else {
                if -translation > (sideBarWidth / 3) {
                    offset = -sideBarWidth
                    showMenu = false
                } else {
                    if offset == 0 || !showMenu {
                        return
                    }
                    offset = 0
                    showMenu = true
                }
            }
        }
        // storing last offset
        lastStoredOffset = offset > 0 ? 0 : offset
    }
}
