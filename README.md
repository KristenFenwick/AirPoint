# AirPoint 🎧

*macOS · Swift · Motion Tracking · Human–Computer Interaction*

What if you could control your Mac's cursor just by moving your head?

AirPoint is an experimental macOS application I developed to explore hands-free computer interaction using the motion sensors built into AirPods.

The project translates head movement into cursor movement, combining software development with an exploration of alternative input methods.

**Tested with:** AirPods Pro (2nd generation, Lightning).

Works with one or both earbuds (just in case you lost one like me! 🥴😅).

You can wear them, or tilt an open case with a bud inside. The case itself has no motion sensor an app can read. The sensor is in the earbud.

Other AirPods Pro and AirPods Max models with head-motion sensors may work, but they have not been tested yet. If you try one, I would like to hear how it goes.

## Getting started

AirPoint is shared as source code. There is no prebuilt app in this repository.

The zip can be downloaded on a Mac, Windows, or Linux. Building and running it needs Xcode, and Xcode installs on a Mac only.

1. Install the Xcode that matches the macOS already on the Mac. The App Store copy is the right one for the public macOS. If Xcode says it is not supported, update macOS or download the matching Xcode from [Apple Developer downloads](https://developer.apple.com/download/all/). Do not install a beta just for this app.
2. On this page, choose **Code**, then **Download ZIP**. Or clone the repository.
3. Create a macOS app in Xcode, SwiftUI, and replace the generated Swift file with `AirPointApp.swift`. Sign it with your Apple ID. A paid developer account is not required to run it on your own Mac.
4. Delete App Sandbox if the target has it. A sandboxed app cannot move the system pointer. Do not add any other capability.
5. In the target Info tab, add **Privacy - Motion Usage Description**. Set it to: `Reads the AirPods head angle to move the pointer.`
6. Run it. Allow Motion. Then allow the app under **System Settings, Privacy and Security, Device Control and Data Access**. On macOS 26 and earlier, that list is named Accessibility.
7. Set the Mac's sound output to the AirPods and press Start.

Look left, right, up, and down. Click with the trackpad, the Click button, or Control-Space. If a direction feels backward, use the flip switches.

While AirPoint is running, it watches key presses so Control-Space can click. It does not record those keys or send them anywhere. Press Stop, or quit, and that watch ends. Motion samples stay on the Mac. There is no network code.

## Feedback

AirPoint is an ongoing experiment. If you test another AirPods model, find a bug, or have an idea, open an issue.

Happy experimenting! 🎧
