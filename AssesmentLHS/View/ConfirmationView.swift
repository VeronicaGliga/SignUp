//
//  ConfirmationView.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 24.10.2024.
//

import SwiftUI

struct ConfirmationView: View {
    // MARK: - Properties
    
    @ObservedObject var viewModel: ConfirmationViewModel
    @State private var showMenu = false

    // MARK: - Body
    
    var body: some View {
        AnimatedSideBar(
            sideMenuWidth: 200,
            cornerRadius: 25,
            showMenu: $showMenu) { _ in
                NavigationStack {
                    VStack(alignment: .leading, spacing: 15) {
                        // Welcome text with user's name and pilot license
                        Text("Welcome, \(viewModel.currentUser.fullName)")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Text("Pilot License: \(viewModel.currentUser.pilotLicenseType.type)")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                            .padding(.top, -10)
                        
                        Text("Allowed Aircrafts")
                            .font(.title2)
                            .padding(.top, 10)
                        
                        List(viewModel.currentUser.pilotLicenseType.aircrafts, id: \.self) { aircraft in
                            Text(aircraft)
                        }
                        .listStyle(.inset)
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 25)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: { showMenu.toggle() }) {
                                Image(systemName: showMenu ? "xmark" : "line.3.horizontal")
                                    .foregroundStyle(Color.primary)
                                    .contentTransition(.symbolEffect)
                            }
                        }
                    }
                }
                .overlay {
                    CircleView()
                        .frame(width: 200, height: 200)
                        /// Moving When the Signup Pages Loads/Dismisses
                        .offset(x: 80, y: -80)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(maxHeight: .infinity, alignment: .top)
                    CircleView()
                        .frame(width: 200, height: 200)
                        /// Moving When the Signup Pages Loads/Dismisses
                        .offset(x: -80, y: -80)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            } menuView: { safeArea in
                SideBarMenuView(safeArea)
            } background: {
                Rectangle()
                .fill(.linearGradient(colors: [.appYellow, .orange, .red],
                                      startPoint: .top,
                                      endPoint: .bottom))
        }
    }
    
    // MARK: - ViewBuilder Functions
    
    @ViewBuilder
    func CircleView() -> some View {
        Circle()
            .fill(.linearGradient(colors: [.appYellow, .orange, .red], 
                                  startPoint: .top,
                                  endPoint: .bottom))
            .blur(radius: 15)
    }
    
    @ViewBuilder
    func SideBarMenuView(_ safeArea: UIEdgeInsets) -> some View {
        VStack(alignment: .leading, spacing: 12) {
           Text("Side Menu")
                .font(.largeTitle.bold())
                .padding(.bottom, 10)
            
            SideBarButton(.home)
            SideBarButton(.bookmark)
            SideBarButton(.favourites)
            SideBarButton(.profile)
            
            Spacer(minLength: 0)
            
            SideBarButton(.logout) {
                viewModel.logout()
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 20)
        .padding(.top, safeArea.top)
        .padding(.bottom, safeArea.bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .environment(\.colorScheme, .dark)
    }
    
    @ViewBuilder
    func SideBarButton(_ tab: Tab, onTap: @escaping () -> () = {  }) -> some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: tab.rawValue)
                    .font(.title3)
                
                Text(tab.title)
                    .font(.callout)
                
                Spacer(minLength: 0)
            }
            .padding(.vertical, 10)
            .contentShape(.rect)
            .foregroundStyle(Color.primary)
        }
    }
    
    /// Sample Tab's
    enum Tab: String, CaseIterable {
        case home = "house.fill"
        case bookmark = "book.fill"
        case favourites = "heart.fill"
        case profile = "person.crop.circle"
        case logout = "rectangle.portrait.and.arrow.forward.fill"
        
        var title: String {
            switch self {
            case .home: return "Home"
            case .bookmark: return "Bookmark"
            case .favourites: return "Favourites"
            case .profile: return "Profile"
            case .logout: return "Logout"
            }
        }
    }
}

#Preview {
    ContentView()
}
