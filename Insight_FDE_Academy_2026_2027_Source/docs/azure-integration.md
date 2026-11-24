# Future Azure integration — design, not connected functionality

## Target architecture

Browser → Entra ID via MSAL.js (authorization code + PKCE) → authenticated Azure Functions API → Azure SQL using managed identity.
Frontend: Azure Static Web Apps. Observability: Application Insights. API role checks and assignment rules are authoritative; browser controls are not security boundaries.

## Identity

1. Register separate SPA and API applications in the intended tenant; configure environment-specific redirect URIs and explicit supported account types.
2. Use MSAL.js from its supported npm package when implementing sign-in. Client/tenant IDs are public configuration; no client secret belongs in the browser.
3. Expose an API scope and define application roles: Learner, Mentor, Leadership, Admin. Assign roles through the tenant's approved process.
4. Validate access-token signature, issuer, audience, expiry, tenant and required scope/role on every API request. Use immutable tenant + object ID as user identity; never trust a submitted learner ID as authorization.
5. Learners access their own records, mentors access assigned learners, leadership accesses authorized summaries. Only administrators manage assignment and curriculum.
6. Remove sample profile switching and gate all actual data paths behind server authorization before production.

## Persistence and API

The current app uses browser-local state in `dist/app.js`. Extract state operations behind an asynchronous repository interface (`listModules`, `getProgress`, `setProgress`, `listWorkLogs`, `saveWorkLog`, `deleteWorkLog`, `listReviews`, `saveReview`, `getInsights`) and implement an authenticated HTTP adapter. `api-contract.yaml` defines the proposed contract.

Apply `database/schema.sql` through a reviewed migration pipeline. Configure an Entra administrator and a least-privilege managed identity database user for the API. Prefer private connectivity where supported by the chosen Azure topology; do not connect a browser directly to SQL. Use parameterized queries, transaction boundaries and rowversion-based concurrency. Enforce module foreign keys, date/minute limits, rubric weights, gate criteria and assignment authorization on the server.

Keep assessments append-only or explicitly versioned. Create audit records for writes and role-sensitive actions. Implement retention, deletion and export policies with the organization's data owners. Use durable evidence storage/links under appropriate permissions, not arbitrary browser file uploads.

## Deployment

1. Provision distinct development, test and production resources (SWA, Functions, SQL, monitoring and secrets/configuration).
2. Implement and test the Functions API; this package intentionally does not deploy a pretend backend.
3. Configure SPA tenant/client/API scope and API base URL per environment. No credentials are provided here.
4. Frontend can deploy independently from `dist`. Copy `azure/staticwebapp.config.json` into `dist` for Azure hosting. The manual GitHub Actions template requires a configured Azure SWA deployment token secret and GitHub environment approval policies where appropriate.
5. Deploy SQL migrations, API and frontend in controlled order; smoke-test Entra sign-in, learner isolation, mentor assignments, leadership access, concurrent edits and rollback.
6. Do not expose real personnel data until identity, access checks, retention, logging and recovery have been verified.

## Primary references (checked November 17, 2026)

- https://learn.microsoft.com/en-us/entra/identity-platform/msal-overview
- https://learn.microsoft.com/en-us/azure/static-web-apps/overview
- https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-overview?view=azuresql
