//
//  SideMenuView.swift
//  SideSlideMenu
//
//  Created by Jay Song on 2022/6/10.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var showMenu: Bool

    private var sideBarWidth: CGFloat

    init(showMenu: Binding<Bool>, sideBarWidth: CGFloat) {
        self._showMenu = showMenu
        self.sideBarWidth = sideBarWidth
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Color.blue
        }
        .frame(width: sideBarWidth)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
