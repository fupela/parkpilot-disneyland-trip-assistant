# Disneyland Trip Assistant

Personal iPhone trip assistant for July 10-11, 2026 Disneyland Resort planning.

## Commands

```bash
swift build
swift test
```

Open `iOS/DisneylandTripAssistant.xcodeproj` in Xcode for simulator, device,
or TestFlight packaging work. The project wraps the shared `TripApp` SwiftUI
module so the preview executable and iPhone target use the same screens.

The first implementation uses deterministic seed data. It does not store Disney credentials or automate Disney account actions.

## Local Test Note

`swift build` and `swift test` both pass in the current macOS/Xcode command-line toolchain used for this public checkout.

## Product Readiness Checklist

- `swift build` passes.
- `swift test` passes in an environment with XCTest available.
- Today screen shows one primary next action.
- Lightning Lane recommendation includes plain-English reasoning and visible factors.
- Disney actions stay human-confirmed in the official Disney app or web flow.
- Vegetarian dining recommendations list specific menu items.
- Stale and unavailable data states are visible.
- July 10 Disneyland and July 11 Disney California Adventure simulations produce coherent ride, food, rest, and entertainment guidance.
- iOS wrapper project opens in Xcode and archives after a development team and app icon are configured.


## Public Repository Notes

This repository is a standalone public copy of a Swift/iOS trip-planning prototype. It contains deterministic seed data and local planning logic only. It does **not** store Disney credentials, scrape Disney services, automate Disney account actions, or include private API keys.

## OpenAI Codex for Open Source Notes

This repository can be used as a public proof artifact for an OpenAI Codex for Open Source application.

- Application notes: `docs/CODEX_FOR_OPEN_SOURCE_APPLICATION.md`
- Privacy posture: `docs/PRIVACY.md`

This is **not** a ChatGPT Apps SDK submission repo. It is a native Swift/iOS prototype with deterministic local planning logic and tests.
