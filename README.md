# BudPointer

BudPointer turns AirPods head motion into the Mac pointer. It works with one earbud or both. AirPods Pro and AirPods Max are the models with the motion sensors.

Side note: use the green Code button on this page and choose Download ZIP. The project builds in Xcode on a Mac. It does not run on Linux or Windows.

This repository is source only. Build it in Xcode on your own Mac. Do not download a prebuilt app from a stranger, and do not add a built `.app` to this repo. A free Apple ID signature only runs on the Mac that built it.

## Build

1. Install the Xcode that matches the macOS already on the Mac. The App Store copy is the right one for the public macOS. If Xcode says it is not supported, update macOS or download the Xcode release that matches it from [Apple Developer downloads](https://developer.apple.com/download/all/). Do not install a beta just for this app.
2. Create a macOS App, SwiftUI, Swift. Sign it with your Apple ID as a Personal Team. A paid developer account is not required to run it on your own Mac.
3. Delete App Sandbox if the target has it. A sandboxed app cannot move the system pointer. Do not add any other capability, and do not add entitlements that start with `com.apple.private`.
4. In the target Info tab, add **Privacy - Motion Usage Description**. Set it to: `Reads the AirPods head angle to move the pointer.`
5. Replace the app's Swift file with `BudPointerApp.swift` from this repo. Delete the template `ContentView.swift` if it is still there.
6. Press Run. Allow Motion. Then allow the app under **System Settings, Privacy & Security, Device Control and Data Access**. On macOS 26 and earlier, that list is named Accessibility.
7. Set the Mac's sound output to the AirPods and press Start.

## Use it in your ears

Put the buds in and close the case. Look left, right, up, and down. The pointer follows the change in head angle, not a fixed spot on the screen. Click with the trackpad, the Click button, or Control-Space. If a direction feels backward, use the flip switches.

One earbud is enough. If a missing bud keeps pausing audio, turn off Automatic Ear Detection under **System Settings, Bluetooth**, the info button next to the AirPods.

## Use the case instead

The case does not have a motion sensor an app can read. The chip in the case is only for Find My. The sensors are in the earbuds.

You can still aim with the case:

1. Leave at least one bud in the case and keep the lid open. Closing the lid disconnects the buds.
2. Turn off Automatic Ear Detection, or the buds stop sending motion when they are not in your ears.
3. Set the Mac's sound output to the AirPods and press Start.
4. Tilt the open case. The bud sits sideways, so the pointer may feel diagonal. Use the flip switches until it feels right.

## Permissions

| Permission | Why |
|---|---|
| Motion and fitness | Read the earbud angle while this Mac is playing audio through the AirPods. The samples stay in memory. Nothing is saved or uploaded. |
| Device Control and Data Access | Post normal mouse moves and clicks. This is the old Accessibility permission, renamed on macOS 27. |

While BudPointer is running, it watches key presses so Control-Space can click. It does not record those keys, send them anywhere, or block them. Quit the app, or press Stop, and the watch ends.

There is no network code in this project.

## Do not commit

Certificates, `.p12` files, provisioning profiles, and built apps do not belong in this repo. The `.gitignore` already excludes them.
