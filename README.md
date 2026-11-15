# BudPointer

Turn AirPods into a hands-free Mac pointer.

BudPointer is an experimental Mac app. It reads motion from the earbuds and moves the cursor when you turn your head. I built it to try a pointer that uses sensors already sitting in everyday hardware, instead of carrying a mouse.

One earbud is enough. Both work too. I was missing one while I built this.

You can also leave a bud in the case, keep the lid open, and tilt the case. The case itself has no motion sensor an app can read. The sensor is in the earbud.

## Tested hardware

Tested with AirPods Pro (2nd generation, Lightning).

AirPods Pro and AirPods Max models that include head-motion sensors may work. They have not been tested here. If you try another model, an issue on this repo is useful.

## Get it running

This is source code. There is no prebuilt app in this repo.

The zip can be downloaded on a Mac, Windows, or Linux. Building and running it needs Xcode, and Xcode installs on a Mac only.

1. Install the Xcode that matches the macOS already on the Mac. The App Store copy is the right one for the public macOS. If Xcode says it is not supported, update macOS or download the matching Xcode from [Apple Developer downloads](https://developer.apple.com/download/all/). Do not install a beta just for this app.
2. On GitHub, choose Code, then Download ZIP. Or clone the repo.
3. Create a macOS app in Xcode, SwiftUI, and replace the generated Swift file with `BudPointerApp.swift`. Sign it with your Apple ID. A paid developer account is not required to run it on your own Mac.
4. Delete App Sandbox if the target has it. A sandboxed app cannot move the system pointer. Do not add any other capability.
5. In the target Info tab, add **Privacy - Motion Usage Description**. Set it to: `Reads the AirPods head angle to move the pointer.`
6. Run it. Allow Motion. Then allow the app under **System Settings, Privacy and Security, Device Control and Data Access**. On macOS 26 and earlier, that list is named Accessibility.
7. Set the Mac's sound output to the AirPods and press Start.

Look left, right, up, and down. Click with the trackpad, the Click button, or Control-Space. If a direction feels backward, use the flip switches.

While BudPointer is running, it watches key presses so Control-Space can click. It does not record those keys or send them anywhere. Press Stop, or quit, and that watch ends. Motion samples stay on the Mac. There is no network code.

## Feedback

If you test another AirPods model, hit a bug, or have an idea, open an issue.
