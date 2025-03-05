//
//  DashboardView_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct DashboardView_V15: View {
	@Binding var selectedTab: TabbarOption

    var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(spacing: 20) {
				DashboardNotificationsView_V15()
				DashboardPaymentsView_V15(selectedTab: $selectedTab)
				DashboardRewardsView_V15(selectedTab: $selectedTab)
			}
			.padding()
		}
		.navigationTitle("Hi, Tom Cruise!")
    }
}

#Preview {
	NavigationView {
		DashboardView_V15(selectedTab: .constant(.home))
	}
}
