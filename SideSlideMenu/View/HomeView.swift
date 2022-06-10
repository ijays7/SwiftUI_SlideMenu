//
//  HomeView.swift
//  SideSlideMenu
//
//  Created by Jay Song on 2022/6/10.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var showMenu: Bool

    var body: some View {
        Button {
            withAnimation {
                showMenu.toggle()
            }
        } label: {
            Text("Show Menu")
        }
    }
}
