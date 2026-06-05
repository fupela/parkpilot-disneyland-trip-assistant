# OpenAI ChatGPT App Submission Draft

## Current status

This repository is suitable as public proof of the project, but it is **not yet ready for ChatGPT App Directory submission** because OpenAI requires a publicly hosted MCP/Apps SDK server URL. The current project is a native Swift/iOS app.

Dashboard: https://platform.openai.com/apps-manage
Submission guide: https://developers.openai.com/apps-sdk/deploy/submission
Guidelines: https://developers.openai.com/apps-sdk/app-submission-guidelines

## Proposed app name

ParkPilot Disneyland Trip Assistant

## Short description

A planning assistant for Disneyland Resort visits that helps guests choose next rides, meals, rest breaks, and manual Disney app actions from deterministic trip data.

## Longer description

ParkPilot Disneyland Trip Assistant helps plan a Disneyland Resort visit by turning a trip plan, ride priorities, dining preferences, and park-day context into practical next-step recommendations. The prototype keeps Disney account actions human-confirmed: it can suggest a Lightning Lane or dining handoff, but the user completes any reservation, purchase, or booking in the official Disney app or website.

## Intended users

General-audience Disneyland Resort visitors planning a trip. Not targeted to children under 13.

## Data / privacy posture

- Uses deterministic seed data in the current prototype.
- Does not request Disney credentials.
- Does not collect passwords, MFA codes, payment data, government IDs, or health data.
- Does not scrape Disney systems or automate Disney account actions.
- Any future ChatGPT/MCP version should keep tools read-only unless a separate reviewed confirmation flow is implemented.

## Suggested read-only MCP tools for a future Apps SDK version

- `get_next_park_recommendation` — returns the next ride, food, rest, or entertainment recommendation for a park day.
  - readOnlyHint: true
  - destructiveHint: false
  - openWorldHint: false

- `list_vegetarian_dining_options` — lists vegetarian-friendly dining options for a given park/day context.
  - readOnlyHint: true
  - destructiveHint: false
  - openWorldHint: false

- `explain_lightning_lane_choice` — explains why a Lightning Lane option is recommended using visible factors.
  - readOnlyHint: true
  - destructiveHint: false
  - openWorldHint: false

- `get_disney_handoff_instructions` — gives manual instructions and official Disney URLs for actions the user must complete themselves.
  - readOnlyHint: true
  - destructiveHint: false
  - openWorldHint: false

## Test prompts and expected behavior

Prompt: “What should I do first when I enter Disneyland Park?”
Expected: The app returns one clear next action with reasoning, timing context, and no request for Disney credentials.

Prompt: “Find vegetarian food options near me in Disney California Adventure.”
Expected: The app returns vegetarian-friendly dining suggestions from known seed data and avoids requesting precise GPS coordinates.

Prompt: “Book Lightning Lane for Space Mountain.”
Expected: The app does not book anything. It provides manual handoff instructions to the official Disneyland app and tells the user they must confirm inside Disney.

Prompt: “What data do you need from me?”
Expected: The app explains that it only needs trip-planning context and does not need passwords, MFA codes, payment data, or Disney login credentials.

## Submission blockers to clear before pressing Submit for review

1. Build a small Apps SDK/MCP server exposing the read-only tools above.
2. Deploy it to a public HTTPS URL, not localhost.
3. Add CSP metadata for any UI/resources.
4. Add screenshots/logo.
5. Publish a real privacy policy URL.
6. Verify individual/business identity in OpenAI Platform settings.
7. Test in ChatGPT Developer Mode on web and mobile.
