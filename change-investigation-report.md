# 🔎 Change Investigation Report

**Target**: `src/components/Footer.jsx` lines 174-186 (the "Contact Us" footer link and its hover tooltip)
**Investigation Date**: 2026-09-28
**Repository**: https://github.com/Venkat-S-Kota/job-portal-ui.git
**Branch**: skills

---

## 📋 Investigation Summary

| Detail                  | Value                                              |
| ------------------------ | --------------------------------------------------- |
| File(s) Analyzed        | `src/components/Footer.jsx`                        |
| Lines Investigated      | 174-186                                            |
| Total Commits on File   | 5                                                   |
| Unique Authors          | 2 (see note below)                                 |
| File Age (First Commit) | 2026-09-26 23:02:55 +0530                          |
| Last Modified           | 2026-09-27 13:29:51 +0530 by Venkat-S-Kota          |

> Note: `VenkataSai-Kota` (initial commit, email `venkatasai.kota@thoughtworks.com`) and `Venkat-S-Kota` (later commits, email `kotavenkatsiva@gmail.com`) appear to be the same person committing under two different local git identities/emails.

---

## 👥 Author Breakdown

| # | Author            | Email                              | Commits | Lines Owned (174-186) | First Contribution | Last Contribution |
| - | ----------------- | ----------------------------------- | ------- | ---------------------- | ------------------- | ------------------- |
| 1 | Venkat-S-Kota      | kotavenkatsiva@gmail.com            | 1       | 6 (46%)                | 2026-09-27           | 2026-09-27           |
| 2 | VenkataSai-Kota    | venkatasai.kota@thoughtworks.com    | 1       | 7 (54%)                | 2026-09-26           | 2026-09-26           |

**Primary Owner (this block)**: VenkataSai-Kota (Initial commit) — structural JSX (Link, span, glow div)
**Most Recent Contributor**: Venkat-S-Kota, added the tooltip markup on 2026-09-27
**CODEOWNERS**: Not configured

---

## 📅 Change Timeline

### f0f877d — 2026-09-27 13:29:51 +0530

- **Author**: Venkat-S-Kota <kotavenkatsiva@gmail.com>
- **Message**: fix: show hover tooltip on footer contact us link (#10)
- **Body**: (none beyond issue reference)
- **Ticket References**: Closes #9
- **Lines Changed**: +6 / -0
- **What Changed**:
  > Added the CSS-only hover tooltip `<div>` (lines 180-185) under the "Contact Us" link, following the same `group`/`group-hover` pattern already used for Privacy Policy, Terms of Service, and Cookie Policy. The tooltip text reads: "Need help or facing an issue? Click here to send a message to our Admin team — we'll get back to you within 24-48 hours." This was a PR co-authored with `claude[bot]` and Claude Opus 5.5, closing issue #9 (the "Contact Us" link had no tooltip while the other footer links did).

### 9aad26c — 2026-09-27 00:47:54 +0530

- **Author**: Venkat-S-Kota <kotavenkatsiva@gmail.com>
- **Message**: fix: add hover tooltip to footer Terms of Service link (#7)
- **Body**: "Mirrors the existing Cookie Policy tooltip so hovering the Terms of Service link in the footer displays informational text instead of nothing."
- **Ticket References**: Fixes #5
- **Lines Changed**: (Terms of Service block only — outside target range, but establishes the pattern later applied to Contact Us)
- **What Changed**:
  > Not part of lines 174-186 directly, but this commit (and the two below) established the repeated tooltip pattern that commit `f0f877d` later applied to the Contact Us link.

### 3d116a3 — 2026-09-27 00:47:35 +0530

- **Author**: Venkat-S-Kota <kotavenkatsiva@gmail.com>
- **Message**: fix: add hover tooltip to footer Privacy Policy link (#6)
- **Ticket References**: Closes #4
- **What Changed**: Same tooltip pattern applied to Privacy Policy link (outside target range).

### 59c0834 — 2026-09-27 00:19:14 +0530

- **Author**: Venkat-S-Kota <kotavenkatsiva@gmail.com>
- **Message**: fix: add hover tooltip to footer Cookie Policy link (#3)
- **Body**: "The Cookie Policy anchor had no href, title, or tooltip markup — hovering only faded in a decorative glow div, so no text ever appeared as reported in #2. Add an inline CSS-only tooltip using the existing group/group-hover idiom already on this element, styled to match the site's dark palette and popover conventions (ConfirmationModal.jsx), with no new component, state, or dependency."
- **Ticket References**: Fixes #2
- **What Changed**: This is the **origin commit** of the tooltip pattern — first applied to Cookie Policy, then copied to Privacy Policy, Terms of Service, and finally Contact Us (lines 174-186).

### e8fd6c8 — 2026-09-26 23:02:55 +0530

- **Author**: VenkataSai-Kota <venkatasai.kota@thoughtworks.com>
- **Message**: Initial commit
- **Body**: "Job Portal UI: React 19 + Vite 7 + Tailwind CSS 4 SPA with mock data layer."
- **Ticket References**: None
- **What Changed**:
  > Introduced the base structure of lines 174-179 (the `<Link to="/contact">` with "Contact Us" text and the decorative glow div) as part of scaffolding the whole footer — at this point, Contact Us had no tooltip.

---

## 🔬 Line-by-Line Blame (Current State)

| Lines    | Author          | Date       | Commit Message                                              |
| -------- | --------------- | ---------- | ------------------------------------------------------------- |
| 174-179  | VenkataSai-Kota | 2026-09-26 | Initial commit                                                 |
| 180-185  | Venkat-S-Kota   | 2026-09-27 | fix: show hover tooltip on footer contact us link (#10)       |
| 186      | VenkataSai-Kota | 2026-09-26 | Initial commit                                                 |

---

## 🎫 Linked Tickets & References

| Ticket ID | Commit    | Author          | Date       | Commit Subject                                                |
| --------- | --------- | --------------- | ---------- | --------------------------------------------------------------- |
| #9        | f0f877d   | Venkat-S-Kota   | 2026-09-27 | fix: show hover tooltip on footer contact us link (#10)          |
| #5        | 9aad26c   | Venkat-S-Kota   | 2026-09-27 | fix: add hover tooltip to footer Terms of Service link (#7)     |
| #4        | 3d116a3   | Venkat-S-Kota   | 2026-09-27 | fix: add hover tooltip to footer Privacy Policy link (#6)       |
| #2        | 59c0834   | Venkat-S-Kota   | 2026-09-27 | fix: add hover tooltip to footer Cookie Policy link (#3)        |
| —         | e8fd6c8   | VenkataSai-Kota | 2026-09-26 | Initial commit (no ticket)                                       |

All four tooltip fixes reference a GitHub issue (#9, #5, #4, #2) and were each merged via a corresponding PR (#10, #7, #6, #3) — a consistent, well-documented pattern.

---

## 💡 Insights

- **Churn Assessment**: Low churn overall, but the target block (lines 174-186) has changed once since the initial commit, within about 14.5 hours of the file's creation — this whole footer link/tooltip section was actively iterated on the same day. Not a sign of instability; it reflects a deliberate, incremental rollout of the same tooltip pattern across four footer links (Cookie Policy → Privacy Policy → Terms of Service → Contact Us), each in its own PR.
- **Bus Factor**: Only one contributor (across two git identities) has ever touched this file — high bus factor risk in isolation, but expected for a solo/bootcamp-style project at this stage.
- **Stale Code Risk**: None — file is one day old as of investigation.
- **Review Gaps**: No gaps. Every substantive change to this block is tied to a GitHub issue and a PR (#10 fixing #9), and the commits were co-authored with Claude, suggesting AI-assisted PR review was used consistently.
- **Pattern Note**: The Contact Us tooltip (line 182) is the last of four near-identical tooltips added to the footer (Privacy Policy, Terms of Service, Cookie Policy, Contact Us), each added in its own PR mirroring the prior one — worth knowing if a future change needs to touch all four consistently (e.g., a copy update or restyle should probably touch lines ~148-150, 159-160, 169-170, and 182 together).

---

## ═══════════════════════════════════════════════════════════════
  🔎 CHANGE INVESTIGATION COMPLETE
═══════════════════════════════════════════════════════════════

  Target:          Footer.jsx:174-186 (Contact Us link + tooltip)
  File(s):         src/components/Footer.jsx

  📊 Quick Stats:
     Total Commits:    5 (file-wide), 2 touching this exact block
     Unique Authors:   2 (likely same person, two git identities)
     File Age:         ~1 day (2026-09-26 → 2026-09-27)
     Last Changed:     2026-09-27 13:29:51 by Venkat-S-Kota

  👤 Primary Owner (block):    VenkataSai-Kota (Initial commit, structural JSX)
  👤 Last Contributor:         Venkat-S-Kota, added tooltip on 2026-09-27 (PR #10, closes #9)

  🎫 Ticket References Found: 4 (#9, #5, #4, #2)
  ⚠️  Commits Without Tickets: 1 (Initial commit — expected, no tracker yet)

  📄 Full report saved: ./change-investigation-report.md
═══════════════════════════════════════════════════════════════
