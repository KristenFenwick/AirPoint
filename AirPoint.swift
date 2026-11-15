import SwiftUI
import Combine
import CoreMotion
import CoreGraphics
import ApplicationServices

@main
struct AirPoint: App {
    var body: some Scene {
        WindowGroup {
            ControlView()
                .frame(minWidth: 420, minHeight: 320)
        }
    }
}

@MainActor
final class HeadMouse: ObservableObject {
    @Published var status = "AirPod in, or the case lid open with a bud inside. Mac sound output set to the AirPods."
    @Published var running = false
    @Published var flipX = false
    @Published var flipY = false
    @Published var sensitivity: Double = 1100

    private let motion = CMHeadphoneMotionManager()
    private var lastYaw: Double?
    private var lastPitch: Double?
    private var keyMonitor: Any?

    func start() {
        if !AXIsProcessTrusted() {
            let key = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String
            AXIsProcessTrustedWithOptions([key: true] as CFDictionary)
            status = "Turn this app on under Privacy and Security, then Device Control and Data Access. Press Start again."
            return
        }
        guard motion.isDeviceMotionAvailable else {
            status = "No headphone motion yet. The AirPods have to be this Mac's sound output."
            return
        }
        lastYaw = nil
        lastPitch = nil
        motion.startDeviceMotionUpdates(to: .main) { [weak self] sample, error in
            MainActor.assumeIsolated {
                if let error {
                    self?.status = error.localizedDescription
                    return
                }
                if let sample { self?.apply(sample) }
            }
        }
        if keyMonitor == nil {
            keyMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
                let control = event.modifierFlags.contains(.control)
                let characters = event.charactersIgnoringModifiers
                MainActor.assumeIsolated {
                    if control && characters == " " {
                        self?.click()
                    }
                }
            }
        }
        running = true
        status = "Tracking. Look, or tilt the open case. Control-Space clicks."
    }

    func stop() {
        motion.stopDeviceMotionUpdates()
        if let keyMonitor { NSEvent.removeMonitor(keyMonitor) }
        keyMonitor = nil
        running = false
        lastYaw = nil
        lastPitch = nil
        status = "Stopped."
    }

    func click() {
        guard AXIsProcessTrusted(), let event = CGEvent(source: nil) else { return }
        let loc = event.location
        CGEvent(mouseEventSource: nil, mouseType: .leftMouseDown, mouseCursorPosition: loc, mouseButton: .left)?
            .post(tap: .cghidEventTap)
        CGEvent(mouseEventSource: nil, mouseType: .leftMouseUp, mouseCursorPosition: loc, mouseButton: .left)?
            .post(tap: .cghidEventTap)
    }

    private func apply(_ sample: CMDeviceMotion) {
        let yaw = sample.attitude.yaw
        let pitch = sample.attitude.pitch
        guard let previousYaw = lastYaw, let previousPitch = lastPitch else {
            lastYaw = yaw
            lastPitch = pitch
            return
        }
        lastYaw = yaw
        lastPitch = pitch
        var dyaw = wrap(yaw - previousYaw)
        var dpitch = wrap(pitch - previousPitch)
        if abs(dyaw) > 0.35 || abs(dpitch) > 0.35 { return }
        if abs(dyaw) < 0.003 { dyaw = 0 }
        if abs(dpitch) < 0.003 { dpitch = 0 }
        var dx = -dyaw * sensitivity
        var dy = -dpitch * sensitivity
        if flipX { dx = -dx }
        if flipY { dy = -dy }
        move(dx: dx, dy: dy)
    }

    private func wrap(_ angle: Double) -> Double {
        var value = angle
        while value > .pi { value -= 2 * .pi }
        while value < -.pi { value += 2 * .pi }
        return value
    }

    private func move(dx: Double, dy: Double) {
        guard abs(dx) > 0.15 || abs(dy) > 0.15 else { return }
        guard let event = CGEvent(source: nil) else { return }
        let next = CGPoint(x: event.location.x + dx, y: event.location.y + dy)
        CGEvent(mouseEventSource: nil, mouseType: .mouseMoved, mouseCursorPosition: next, mouseButton: .left)?
            .post(tap: .cghidEventTap)
    }
}

struct ControlView: View {
    @StateObject private var mouse = HeadMouse()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("AirPoint").font(.title2.weight(.semibold))
            Text(mouse.status)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            HStack {
                Button(mouse.running ? "Stop" : "Start") {
                    mouse.running ? mouse.stop() : mouse.start()
                }
                Button("Click") { mouse.click() }
                    .disabled(!mouse.running)
            }
            Toggle("Flip left and right", isOn: $mouse.flipX)
            Toggle("Flip up and down", isOn: $mouse.flipY)
            HStack {
                Text("Sensitivity")
                Slider(value: $mouse.sensitivity, in: 400...2200)
            }
        }
        .padding(24)
    }
}
