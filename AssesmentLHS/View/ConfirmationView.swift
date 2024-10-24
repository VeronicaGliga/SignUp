//
//  ConfirmationView.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 24.10.2024.
//

import SwiftUI

struct ConfirmationView: View {
    var userName: String
    var pilotLicense: String
    var allowedAircraft: [String]
    var logoutAction: () -> Void
    
    @State private var showMenu = false

    var body: some View {
        AnimatedSideBar(
            sideMenuWidth: 200,
            cornerRadius: 25,
            showMenu: $showMenu) { _ in
                NavigationStack {
                    VStack(alignment: .leading, spacing: 15) {
                        // Welcome text with user's name and pilot license
                        Text("Welcome, \(userName)")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Text("Pilot License: \(pilotLicense)")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                            .padding(.top, -10)
                        
                        // List of allowed aircraft
                        Text("Allowed Aircrafts")
                            .font(.title2)
                            .padding(.top, 10)
                        
                        List(allowedAircraft, id: \.self) { aircraft in
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
        } menuView: { safeArea in
            SideBarMenuView(safeArea)
        } background: {
            Rectangle()
                .fill(.linearGradient(colors: [.appYellow, .orange, .red], startPoint: .top, endPoint: .bottom))
        }
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
                logoutAction()
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
        Button(action: onTap, label: {
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
        })
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

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(userName: "John Doe", pilotLicense: "ABC12345", allowedAircraft: ["Boeing 737", "Airbus A320"], logoutAction: {})
    }
}
