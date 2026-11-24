# FDE Academy — Winter Arc 2026

Responsive multi-page interactive prototype. Original academy structure adapted to a 30-day December train-the-trainer sprint. Insight-inspired magenta, violet, blue and white; not an official Insight product.

## Run

No installation or build required. Open `dist/index.html`, or serve the directory for reliable shared local storage:

```bash
python3 -m http.server 8080 --directory dist
```

Open http://localhost:8080. The site is static, uses system fonts and has no external runtime dependencies. Resource links need internet access. Do not put confidential learner data into this demo.

## Pages

- index.html — overview, 30-day roadmap, scope disclosure, export and reset
- catalog.html — all 10 modules, search, phase and completion filters
- course.html?id=1 — objectives, teaching exercise, output, resources, completion
- resources.html — module-linked public resource search
- worklog.html — create, edit, delete, draft and submit work logs
- reviews.html — submitted evidence, weighted six-dimension assessment, gate checks and assessment history
- insights.html — aggregates calculated from demo profiles, logs, module completion and reviews

## Working versus simulated

Working: page navigation, module filtering, public links, per-profile completion, 30 roadmap milestones, log CRUD, input validation, score calculation, gate criteria, review history, leadership aggregation, browser persistence, JSON backup export and sample reset.

Simulated: four fictional sample profiles, profile switching, mentor identity and authority, evidence verification, submissions, readiness decisions and program results. There is no authenticated user session, backend database, email, file upload, cross-device synchronization or enforced role access. Any visitor can operate mentor controls. Completion is self-reported. JSON export is a backup/export only; import is not implemented.

Browser local storage is scoped to the origin. Each visitor gets an independent demo dataset. Storage may be cleared, blocked or differ for file URLs. Never store secrets or real personnel assessments here.

## Curriculum

10 modules: FDE mindset & client craft; Python & API engineering; Data engineering & quality; Platform architecture clinic; RAG, agents & MCP; Governance & responsible AI; Production engineering; Teach-back & peer coaching; Reusable trainer asset library; Showcase & academy launchpad.

The December 1–30, 2026 roadmap has Foundation, Build and Deliver gates on days 10, 20 and 30. December 31 is a buffer. Proposed daily rhythm is 80 minutes, adaptable for leave. Suggested module hours cover learning effort, overlap the roadmap, and are not extra mandatory hours.

Wider academy planning context: 110 teammates, 10 teams, 10 mentors, 12 weeks. December trainer cohort: 8–10. These are planning targets.

## Source organization

`dist/data.js`: curriculum, resources, roadmap, fictional profile definitions.
`dist/app.js`: rendering, local repository/state, validation, CRUD and calculations.
`dist/styles.css`: shared responsive design.
`database/schema.sql`: proposed Azure SQL schema, not applied.
`docs/azure-integration.md`: identity, API, SQL and deployment implementation plan.
`docs/api-contract.yaml`: proposed OpenAPI contract, not implemented.
`azure/staticwebapp.config.json`: static hosting security headers.
`.github/workflows/azure-static.yml`: manual deployment workflow template requiring configuration.

See `docs/validation.md` for checks and limits. The HTML, CSS and JavaScript files are the maintained source; no generation step is required.

## Transformation roadmap update (24 November 2026)
See [docs/transformation-update.md](docs/transformation-update.md) for the December–June roadmap, current functionality boundary, certification checks, migration behavior, sponsor walkthrough and test instructions. This update supersedes older dates and rubric guidance in earlier documentation; the Azure schema/API remain draft integration starting points.
