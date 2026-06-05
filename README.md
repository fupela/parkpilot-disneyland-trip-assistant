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

`swift build` is the reliable local verification command in this checkout. The
currently selected Command Line Tools toolchain fails to import `XCTest`, so
`swift test` may stop with `no such module 'XCTest'` until Xcode's full toolchain
is selected.

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

## ChatGPT / Apps SDK Submission Status

This project is currently a native Swift/iOS app, not a hosted ChatGPT Apps SDK app. To submit it for public ChatGPT distribution, the next implementation step is to add and deploy a public MCP/Apps SDK server that exposes narrow, read-only planning tools backed by this trip-planning logic or equivalent data.

OpenAI's current submission flow requires:

- a publicly accessible MCP server URL,
- a content security policy for any fetched resources,
- app name, logo, screenshots, description, support contact, and privacy policy URL,
- test prompts and expected responses,
- verified individual or organization identity in the OpenAI Platform Dashboard.
