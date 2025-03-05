//
//  PlayView_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct PlayView_V15: View {
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
				NavigationLink("Open example payment") {
					PaymentDetailsView(payment: .example)
				}
				
				NavigationLink("Open payment 123 with loading") {
					PaymentPreDetailsView(paymentId: "123")
				}

				NavigationLink("Open example reward") {
					RewardDetailsView(reward: .example)
				}
				

				NavigationLink("Open reward 123 with loading") {
					RewardPreDetailsView(rewardId: "123")
				}
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
	NavigationView {
		PlayView_V15(selectedTab: .constant(.play), popover: .constant(nil))
	}
}
