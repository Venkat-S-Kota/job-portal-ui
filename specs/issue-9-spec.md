# Technical Specification — Issue #9

## Status: ALREADY RESOLVED

This issue is **closed** and the fix is **already merged into `main`** via commit
`f0f877d` ("fix: show hover tooltip on footer contact us link (#10)"). This spec
documents the resolution for reference; no further implementation work is required.

## 1. Issue Overview

| Field       | Value                                                                                        |
| ----------- | ---------------------------------------------------------------------------------------------|
| Title       | Inside the footer, when hover onto the "Contact Us" nothing being displayed.                 |
| Description | Hovering over the "Contact Us" footer link showed no tooltip/info text, unlike the other footer links (Privacy Policy, Terms of Service, Cookie Policy), which display an explanatory tooltip on hover. |
| Labels      | none                                                                                          |
| Priority    | Low                                                                                           |
| State       | Closed                                                                                        |

## 2. Problem Analysis

`src/components/Footer.jsx` renders four footer links in the bottom bar: "Privacy
Policy", "Terms of Service", "Cookie Policy", and "Contact Us". The first three
each use a `group`/`group-hover` Tailwind pattern to reveal an absolutely
positioned tooltip `<div>` on hover, containing short explanatory copy.

The "Contact Us" link (rendered as a React Router `<Link to="/contact">`) was
missing this tooltip markup — it only had a plain hover color transition, so
nothing appeared on hover, matching the screenshot in the issue.

Root cause: the "Contact Us" link was implemented before the tooltip pattern was
added to the other three links (see prior fixes: `59c0834`, `3d116a3`,
`9aad26c`), and it was never updated to match.

## 3. Proposed Solution (as implemented)

Apply the same tooltip pattern used by the other three footer links to
"Contact Us", with copy relevant to contacting support/admin:

- Wrap the link content in `group relative` classes (already partially present).
- Add the same absolutely positioned tooltip `<div>` (arrow + bubble) shown via
  `group-hover:opacity-100` etc.
- Tooltip text: "Need help or facing an issue? Click here to send a message to
  our Admin team — we'll get back to you within 24-48 hours."
- Preserve existing `to="/contact"` navigation behavior (Link still routes to the
  Contact page, which forwards messages to `/admin/contact-messages`).

No new components, state, or architecture changes were needed — this was a
pure markup/styling parity fix using an existing pattern already present in the
same file.

## 4. Step-by-Step Implementation (completed)

1. **Locate footer links** — `src/components/Footer.jsx`, bottom link row (~line 143 onward).
2. **Copy tooltip markup** from "Cookie Policy" link onto the "Contact Us" `<Link>`.
3. **Write tooltip copy** specific to contacting the Admin team.
4. **Commit & push** as `fix: show hover tooltip on footer contact us link` (PR #10, merged in `f0f877d`).

## 5. Verification Strategy

### Unit Tests
- Not applicable — no existing test suite covers `Footer.jsx`; change is purely presentational.

### Integration Tests
- N/A (no component test harness configured in this repo per `CLAUDE.md`).

### Manual Checks (performed)
- Hover "Contact Us" in the footer → tooltip bubble appears with admin-contact copy. ✅
- Click "Contact Us" → still navigates to `/contact`. ✅
- Visual parity with Privacy Policy / Terms of Service / Cookie Policy tooltips (size, position, animation). ✅

## 6. Files to Modify

| File Path                       | Nature of Change                                              |
| -------------------------------- | -------------------------------------------------------------- |
| `src/components/Footer.jsx`      | Added hover tooltip markup to "Contact Us" link (lines ~174-186) |

## 7. New Files to Create

None.

## 8. Existing Utilities to Leverage

| Utility / Pattern                                    | Benefit                                                        |
| ------------------------------------------------------ | --------------------------------------------------------------- |
| Existing `group`/`group-hover` Tailwind tooltip pattern (Privacy Policy, Terms of Service, Cookie Policy links) | Reused verbatim for visual and behavioral consistency; no new CSS or components needed. |

## 9. Acceptance Criteria

- [x] Hovering "Contact Us" displays an informational tooltip.
- [x] Tooltip visually matches the other footer link tooltips.
- [x] Link still navigates to `/contact` on click.
- [x] No regressions to other footer links.
- [x] Merged to `main` (commit `f0f877d`, PR #10).

## 10. Out of Scope

- Adding automated component/UI tests for the footer (no test infra exists in this repo).
- Redesigning the footer or tooltip system.
- Changing the `/contact` page or admin contact-message handling.
