# Codex for Open Source Application Notes

This document is written for OpenAI's Codex for Open Source program, not for ChatGPT Apps SDK submission.

Program page: https://developers.openai.com/community/codex-for-oss
Application form: https://openai.com/form/codex-for-oss/

## Repository to submit

https://github.com/fupela/parkpilot-disneyland-trip-assistant

## What this repository is

ParkPilot Disneyland Trip Assistant is a public Swift/iOS prototype that turns deterministic Disneyland Resort trip data into practical next-step recommendations for rides, food, rest breaks, and manual Disney app handoffs.

The project demonstrates:

- Swift Package Manager project structure
- SwiftUI application architecture
- shared app/core modules
- deterministic recommendation logic
- privacy-conscious handling of user actions
- test coverage for trip planning, dining recommendations, safety handoffs, and state persistence
- no stored Disney credentials, no Disney scraping, and no automated Disney account actions

## Short application blurb

I maintain ParkPilot Disneyland Trip Assistant, a public Swift/iOS open-source prototype for privacy-conscious theme park trip planning. The project uses deterministic planning data and testable Swift modules to recommend next rides, dining options, rest breaks, and safe manual handoffs to official Disney flows without storing credentials or automating account actions.

I am applying for Codex for Open Source support so I can use ChatGPT Pro with Codex and API credits to improve the project faster: expanding test coverage, reviewing SwiftUI architecture, hardening privacy/safety boundaries, improving docs, and preparing a clean mobile install workflow for contributors and testers.

## Strongest qualification argument

The strongest reason this repository fits the program is that it is a real public open-source project with active maintainer work that maps directly to Codex's stated use cases: coding, review, test generation, documentation, release workflows, and safety/privacy hardening. It is not a placeholder repo; it has working Swift/iOS code, separated app/core modules, a public privacy posture, and passing automated tests. Codex would be used for concrete maintainer tasks rather than general ChatGPT usage.

## Why Codex would help

Codex would reduce maintainer load by helping with:

- Swift and SwiftUI code review
- test generation and refactoring
- accessibility checks for the iOS UI
- privacy and safety review of Disney handoff behavior
- documentation improvements for local builds and iPhone installs
- future release workflows and contributor onboarding

## Honest eligibility note

OpenAI describes Codex for Open Source as focused on core maintainers and widely used public projects. This repository is currently an early public prototype, not a widely used ecosystem-critical project. The strongest honest positioning is: apply anyway, explain that it is a real public project, show working code/tests, and state clearly how Codex would help maintain and improve it.

## Suggested form answers

### Project / repository URL

https://github.com/fupela/parkpilot-disneyland-trip-assistant

### Project name

ParkPilot Disneyland Trip Assistant

### Your role

Maintainer / creator

### What does the project do?

ParkPilot Disneyland Trip Assistant is a Swift/iOS trip-planning assistant for Disneyland Resort visits. It uses deterministic trip data and local recommendation logic to suggest next rides, dining options, rest breaks, and manual Disney app handoffs. It is intentionally designed not to collect Disney credentials, scrape Disney systems, or automate account actions.

### Why is this useful?

The project explores a privacy-conscious pattern for consumer travel assistants: give helpful context-aware recommendations while keeping user-controlled actions in the official app or website. The architecture separates reusable trip-planning logic from the SwiftUI app surface and includes tests for recommendation, dining, notification, and handoff behavior.

### How would you use ChatGPT Pro with Codex / API credits?

I would use Codex for code review, SwiftUI refactoring, test generation, accessibility review, documentation cleanup, and contributor-friendly release/build workflows. API credits would support maintainer automation and review workflows around pull requests, tests, and future safety checks.

### What should reviewers look at?

- `README.md` for project overview and build/test commands
- `Sources/TripCore/` for planning models and recommendation logic
- `Sources/TripApp/` for SwiftUI app screens
- `Tests/TripCoreTests/` for behavior coverage
- `docs/PRIVACY.md` for the privacy posture

## Local verification

```bash
swift build
swift test
```

Latest local verification before publication: build and test passed with 20 tests and 0 failures.
