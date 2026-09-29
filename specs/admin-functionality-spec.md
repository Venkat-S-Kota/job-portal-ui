# Feature Guide — Admin Functionality

## What It Does

The admin role (`ROLE_ADMIN`) gives a logged-in administrator (dummy account
`admin@portal.com` / `admin123`, defined in `src/context/AuthContext.jsx:102-110`)
access to a dedicated `/admin/*` section with four screens: a dashboard,
company management (CRUD), employer management (search/elevate users and
assign them to companies), and contact-message triage. These routes are
hidden from the public Navbar and blocked for other roles by `ProtectedRoute`.

## User Flow

1. User logs in via `/login` → `AuthContext.login()` matches credentials
   against `DUMMY_USERS.admins` (or a registered user elevated to
   `ROLE_ADMIN`) and stores `{ role: 'ROLE_ADMIN', ... }` on `user` state,
   persisted to `localStorage.jobPortalUser` / `authToken`.
2. `Navbar.jsx` reads `isAdmin` from `useAuth()` (line 11) and, when true,
   renders an "Admin" badge and links to `/admin/companies`,
   `/admin/employers`, `/admin/contact-messages` (lines 165-350).
3. Visiting any `/admin*` route is wrapped by
   `<ProtectedRoute allowedRoles={['ROLE_ADMIN']}>` in `src/App.jsx:98-130`.
   `ProtectedRoute` (`src/components/ProtectedRoute.jsx`) redirects
   unauthenticated users to `/login` and redirects wrong-role users to `/`
   (line 22).
4. **Dashboard (`/admin`)** — `src/pages/admin/Dashboard.jsx` shows three
   cards (Company Management, Employer Management, Contact Messages) linking
   into the sub-pages; the company count badge comes from
   `useCompanies().companies.length`.
5. **Company Management (`/admin/companies`)** —
   `src/pages/admin/CompanyManagement.jsx` lists companies from
   `useCompanies()` and lets the admin create/edit/delete a company via a
   form.
6. **Employer Management (`/admin/employers`)** —
   `src/pages/admin/EmployerManagement.jsx` lets the admin search a user by
   email, elevate a `ROLE_JOB_SEEKER`/registered user to `ROLE_EMPLOYER`, and
   assign them to a company.
7. **Contact Messages (`/admin/contact-messages`)** —
   `src/pages/admin/ContactMessages.jsx` lists paginated/sorted `OPEN`
   messages submitted through the public `/contact` form and lets the admin
   close them.

## Key Files

| File | Role |
|---|---|
| `src/App.jsx` (lines 24-27, 98-130) | Registers `/admin`, `/admin/companies`, `/admin/employers`, `/admin/contact-messages` routes, each wrapped in `ProtectedRoute allowedRoles={['ROLE_ADMIN']}` |
| `src/components/ProtectedRoute.jsx` | Role/auth gate for all admin routes |
| `src/components/Navbar.jsx` (lines 165-350) | Shows admin nav links when `isAdmin` is true |
| `src/context/AuthContext.jsx` | Defines the dummy admin user, `isAdmin` flag, login/role persistence |
| `src/pages/admin/Dashboard.jsx` | Admin landing page, links to the three management screens |
| `src/pages/admin/CompanyManagement.jsx` | CRUD UI for companies |
| `src/pages/admin/EmployerManagement.jsx` | Search users, elevate role, assign company |
| `src/pages/admin/ContactMessages.jsx` | Paginated/sorted contact message inbox, close action |
| `src/contexts/CompaniesContext.jsx` | Shared cached company list (5-min TTL) used by Dashboard/CompanyManagement/EmployerManagement |
| `src/services/companyService.js` | `fetchCompanies()` reads from `src/data/mockData.js` |
| `src/services/contactService.js` | Contact message CRUD/pagination against `localStorage.contactMessages` |

## Data Flow Diagram

```
Company Management:
Admin submits form → CompanyManagement.handleSubmit()
   → writes to localStorage["companiesOverrides"] / ["deletedCompanyIds"]
   → calls useCompanies().refetch()
      → CompaniesContext.loadCompanies(force=true)
         → companyService.fetchCompanies() (reads src/data/mockData.js only)
   → setCompanies(data) → CompanyManagement re-renders from contextCompanies

Employer Management:
Admin searches email → EmployerManagement.handleSearchUser()
   → reads localStorage["registeredUsers"] + hardcoded DUMMY_USERS list
Admin clicks "Elevate"/"Assign" → mutates the matching entry in
   localStorage["registeredUsers"] directly (role or companyId/companyName)

Contact Messages:
Page load / sort / page change → ContactMessages.fetchMessages()
   → contactService.fetchOpenContactMsgsWithPaginationAndSort()
      → reads localStorage["contactMessages"], filters status==="OPEN", sorts, paginates
Admin clicks close → contactService.updateContactStatus(id, "CLOSED")
   → mutates localStorage["contactMessages"] → fetchMessages() re-runs
```

## State & Storage

- **AuthContext state**: `user` (object with `role: 'ROLE_ADMIN'`), `isAdmin`
  (boolean derived from `user?.role`).
- **CompaniesContext state**: `companies` (array), `loading`, `error`,
  `lastFetchTime` (5-minute cache, shared across Dashboard/CompanyManagement/
  EmployerManagement).
- **Page-local state**: form fields, search results, pagination
  (`pageNumber`, `pageSize`, `totalPages`, `totalElements`) in
  `ContactMessages.jsx`.
- **localStorage keys involved**:
  - `jobPortalUser`, `authToken` — admin session (set by `AuthContext`).
  - `registeredUsers` — array of user records; `EmployerManagement` mutates
    `role` and `companyId`/`companyName` directly on entries here.
  - `companiesOverrides` — object keyed by company id, intended to hold admin
    edits/new companies (written by `CompanyManagement.handleSubmit`).
  - `deletedCompanyIds` — array of ids the admin "deleted" (written by
    `CompanyManagement.confirmDelete`).
  - `contactMessages` — array of `{ id, ..., status: 'OPEN'|'CLOSED',
    createdAt }`, written by the public contact form
    (`contactService.submitContactForm`) and read/updated by
    `ContactMessages.jsx`.

## How to Extend

- **Known gap**: `companyService.fetchCompanies()`
  (`src/services/companyService.js:7-13`) only reads `companiesData` from
  `src/data/mockData.js` and never merges `companiesOverrides` or filters
  `deletedCompanyIds`. So company create/edit/delete in
  `CompanyManagement.jsx` writes to those localStorage keys but has **no
  visible effect** after `refetch()` — this is the first thing to fix if
  extending company CRUD (merge overrides and filter deletions inside
  `fetchCompanies`, similar to how `fetchAllJobs` merges `globalPostedJobs`).
- To add a new admin screen: create it under `src/pages/admin/`, add an entry
  + `ProtectedRoute allowedRoles={['ROLE_ADMIN']}` route in `src/App.jsx`, and
  add a nav link in `Navbar.jsx`'s `isAdmin` block (per
  `.claude/rules/routing-and-roles.md`).
- To back admin actions with a real API later, replace the direct
  `localStorage` reads/writes in `CompanyManagement.jsx` /
  `EmployerManagement.jsx` / `contactService.js` with calls into new/expanded
  service functions (keeping the `delay()` simulation convention from
  `src/utils/delay.js` until a real backend exists), so pages keep using
  services rather than touching storage directly (per
  `.claude/rules/data-layer.md`).
- Employer elevation/assignment (`EmployerManagement.jsx`) has no equivalent
  service file — logic lives inline in the page component; consider
  extracting a `userManagementService.js` for consistency with the rest of
  the codebase.
