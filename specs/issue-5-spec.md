# Technical Specification — Issue #5

## Status: ALREADY RESOLVED

This issue is **closed** and the fix is **already merged into `main`** via commit
`9aad26c` ("fix: add hover tooltip to footer Terms of Service link (#7)"). This
spec documents the resolution for reference; no further implementation work is
required.

## 1. Issue Overview

| Field       | Value                                                                                        |
| ----------- | ---------------------------------------------------------------------------------------------|
| Title       | Inside the footer, when hover onto the "Terms of Service" nothing being displayed.           |
| Description | Hovering over the "Terms of Service" footer link showed no tooltip/info text. It should display text regarding the Terms of Service. |
| Labels      | none                                                                                          |
| Priority    | Low                                                                                           |
| State       | Closed                                                                                        |

## 2. Problem Analysis

`src/components/Footer.jsx` renders the footer bottom-bar links "Privacy
Policy", "Terms of Service", "Cookie Policy", and "Contact Us". At the time
this issue was filed, "Terms of Service" had no `group-hover` tooltip markup,
so nothing appeared on hover — matching the screenshot in the issue.

Root cause: the tooltip pattern (`group`/`group-hover` Tailwind classes plus an
absolutely positioned tooltip `<div>` with an arrow) had already been applied
to "Cookie Policy" (commit `59c0834`) but not yet to "Terms of Service", which
was fixed one commit later in `9aad26c`.

## 3. Proposed Solution (as implemented)

Apply the same tooltip pattern already used elsewhere in the footer to the
"Terms of Service" link:

- Wrap the link in `group relative` classes.
- Add the absolutely positioned tooltip `<div>` (bubble + arrow), shown via
  `group-hover:opacity-100`, `group-hover:scale-100`, `group-hover:translate-y-0`.
- Tooltip copy: "Our full Terms of Service are coming soon — by using this
  site you agree to our fair-use guidelines in the meantime." (`Footer.jsx:155-162`)

No new components, state, or architecture changes were required — a pure
markup/styling parity fix reusing an existing pattern already present in the
same file (from the "Cookie Policy" fix).

## 4. Step-by-Step Implementation (completed)

1. **Locate footer links** — `src/components/Footer.jsx`, bottom link row.
2. **Copy tooltip markup** from the "Cookie Policy" link onto "Terms of Service".
3. **Write tooltip copy** specific to Terms of Service.
4. **Commit & push** as `fix: add hover tooltip to footer Terms of Service link` (PR #7, merged in `9aad26c`).

## 5. Verification Strategy

### Unit Tests
- Not applicable — no existing test suite covers `Footer.jsx`; change is purely presentational.

### Integration Tests
- N/A (no component test harness configured in this repo per `CLAUDE.md`).

### Manual Checks (performed)
- Hover "Terms of Service" in the footer → tooltip bubble appears with the ToS copy. ✅
- Visual parity with the other footer link tooltips (size, position, animation). ✅
- No regressions to adjacent "Privacy Policy" / "Cookie Policy" / "Contact Us" links. ✅

## 6. Files to Modify

| File Path                       | Nature of Change                                                    |
| -------------------------------- | ---------------------------------------------------------------------|
| `src/components/Footer.jsx`      | Added hover tooltip markup to "Terms of Service" link (lines ~154-163) |

## 7. New Files to Create

None.

## 8. Existing Utilities to Leverage

| Utility / Pattern                                                     | Benefit                                                        |
| ------------------------------------------------------------------------| --------------------------------------------------------------- |
| Existing `group`/`group-hover` Tailwind tooltip pattern (from "Cookie Policy" link) | Reused verbatim for visual and behavioral consistency; no new CSS or components needed. |

## 9. Acceptance Criteria

- [x] Hovering "Terms of Service" displays an informational tooltip.
- [x] Tooltip visually matches the other footer link tooltips.
- [x] No regressions to other footer links.
- [x] Merged to `main` (commit `9aad26c`, PR #7).

## 10. Out of Scope

- Adding automated component/UI tests for the footer (no test infra exists in this repo).
- Redesigning the footer or tooltip system.
- Drafting actual legal Terms of Service content.
