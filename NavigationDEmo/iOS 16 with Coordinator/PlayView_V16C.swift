//
//  PlayView_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct PlayView_V16C: View {
	@EnvironmentObject var coordinator: Coordinator
	@State var selectedOption: TabbarOption = .home
	@State var needToOpenTab = false

    var body: some View {
		List {
			Section("Select a Tab to work with") {
				Picker("", selection: $selectedOption) {
					ForEach([TabbarOption.home, .payments, .rewards]) {
						Text($0.name)
							.tag($0)
					}
				}
				.pickerStyle(.segmented)
				
				Toggle("Need to open Tab", isOn: $needToOpenTab)
			}
			
			Section("Push") {
				Button("Open example payment") {
					coordinator.open(.payment(.example), in: selectedOption, needToOpenTabIfDifferent: needToOpenTab)
				}
				Button("Open payment 123 with loading") {
					coordinator.open(.needToLoad(.paymentId(id: "123")), in: selectedOption, needToOpenTabIfDifferent: needToOpenTab)
				}
				Button("Open example reward") {
					coordinator.open(.reward(.example), in: selectedOption, needToOpenTabIfDifferent: needToOpenTab)
				}
				Button("Open reward 123 with loading") {
					coordinator.open(.needToLoad(.rewardId(id: "123")), in: selectedOption, needToOpenTabIfDifferent: needToOpenTab)
				}
				
			}
			
			Section("Popover") {
				Button("Open example payment") {
					coordinator.openPopover(.payment(.example))
				}
				Button("Open payment 123 with loading") {
					coordinator.openPopover(.needToLoad(.paymentId(id: "123")))
				}
				Button("Open example reward") {
					coordinator.openPopover(.reward(.example))
				}
				Button("Open reward 123 with loading") {
					coordinator.openPopover(.needToLoad(.rewardId(id: "123")))
				}
			}
			
			Section("Navigation") {
				Button("Pop to root") {
					coordinator.popToRoot(tab: selectedOption, needToOpenTabIfDifferent: needToOpenTab)
				}
				
				Button("Back") {
					coordinator.back(for: selectedOption, needToOpenTabIfDifferent: needToOpenTab)
				}
				
				Button("Back twice") {
					coordinator.back(steps: 2, tab: selectedOption, needToOpenTabIfDifferent: needToOpenTab)
				}
			}
		}
		.tint(.primary)
    }
}


#Preview {
	if #available(iOS 16.0, *) {
		PlayView_V16C()
			.environmentObject(Coordinator())
	}
}
