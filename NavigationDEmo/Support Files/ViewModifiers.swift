//
//  ViewModifiers.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import Foundation
import SwiftUI

private struct DismissableNavigationModifier: ViewModifier {
	@Environment(\.dismiss) var dismiss

	func body(content: Content) -> some View {
		if #available(iOS 16.0, *) {
			NavigationStack {
				content
					.toolbar {
						ToolbarItem(placement: .topBarTrailing) {
							Button("", systemImage: "xmark") { dismiss() }
						}
					}
			}
		} else {
			NavigationView {
				content
					.toolbar {
						ToolbarItem(placement: .topBarTrailing) {
							Button("", systemImage: "xmark") { dismiss() }
						}
					}
			}
		}
	}
}

private struct NavigationDestinationsModifier: ViewModifier {

	func body(content: Content) -> some View {
		if #available(iOS 16.0, *) {
			content
				.navigationDestination(for: Payment.self) {
					PaymentDetailsView(payment: $0)
				}
				.navigationDestination(for: Reward.self) {
					RewardDetailsView(reward: $0)
				}
				.navigationDestination(for: DeepLink.self) {
					switch $0 {
					case .paymentId(let id):
						PaymentPreDetailsView(paymentId: id)
					case .rewardId(let id):
						RewardPreDetailsView(rewardId: id)
					}
				}
		} else {
			content
		}
	}
}

private struct PopoverListenerModifier: ViewModifier  {
	@Binding var popover: CoordinatorNavigatorPath?
	
	func body(content: Content) -> some View {
		content
			.popover(item: $popover) {
				makeView(from: $0)
					.wrapToDismissableNavigation()
			}
	}
	
	private func makeView(from popover: CoordinatorNavigatorPath) -> some View {
		VStack {
			switch popover {
			case .payment(let payment):
				PaymentDetailsView(payment: payment)
			case .reward(let reward):
				RewardDetailsView(reward: reward)
			case .needToLoad(let deepLink):
				switch deepLink {
				case .paymentId(let id):
					PaymentPreDetailsView(paymentId: id)
				case .rewardId(let id):
					RewardPreDetailsView(rewardId: id)
				}
			}
		}
	}
}

extension View {
	
	func popoverListener(for popover:  Binding<CoordinatorNavigatorPath?>) -> some View {
		modifier(PopoverListenerModifier(popover: popover))
	}

	func wrapToDismissableNavigation() -> some View {
		modifier(DismissableNavigationModifier())
	}

	func addNavigationDestinations() -> some View {
		modifier(NavigationDestinationsModifier())
	}
}
