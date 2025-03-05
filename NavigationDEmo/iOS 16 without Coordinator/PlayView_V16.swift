//
//  PlayView_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct PlayView_V16: View {
	@Binding var selectedTab: TabbarOption
	@Binding var popover: CoordinatorNavigatorPath?

    var body: some View {
		List {
			Section("Change Tab") {
				ForEach(TabbarOption.allCases) { tab in
					Button(tab.name, systemImage: tab.iconName) {
						selectedTab = tab
					}
				}
			}
			
			Section("Push") {
				NavigationLink("Open example payment", value: Payment.example)

				NavigationLink("Open payment 123 with loading", value: DeepLink.paymentId(id: "123"))

				NavigationLink("Open example reward", value: Reward.example)

				NavigationLink("Open reward 123 with loading", value: DeepLink.rewardId(id: "123"))
			}
			
			Section("Popover") {
				Button("Open example payment") {
					popover = .payment(.example)
				}
				
				Button("Open payment 123 with loading") {
					popover = .needToLoad(.paymentId(id: "123"))
				}
				
				Button("Open example reward") {
					popover = .reward(.example)
				}
				
				Button("Open reward 123 with loading") {
					popover = .needToLoad(.rewardId(id: "123"))

				}
			}
		}
		.tint(.primary)
    }
}


#Preview {
	if #available(iOS 16.0, *) {
		NavigationStack {
			PlayView_V16(selectedTab: .constant(.play), popover: .constant(nil))
				.addNavigationDestinations()
		}
	}
}
