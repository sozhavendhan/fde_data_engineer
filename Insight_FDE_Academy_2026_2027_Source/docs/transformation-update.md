# December 2026–June 2027 transformation update

## Run
Buildless static site. Open dist/index.html or run `python3 -m http.server 8080 --directory dist`, then open http://localhost:8080. External learning links need internet. Use a stable origin for browser-local demo persistence.

## Sponsor walkthrough (5 minutes)
1. Overview: select December, Q1 and Q2; compare exact dates, evidence and proposed targets. Review the 30-day December outputs.
2. Domain Solutions: expand Retail, inspect architecture and KPI, change the demo status to MVP prototype.
3. Learning Catalog: open Learning Resources beside objectives. Open a PDF/video reference, expand View all, then compare the course-details page and central library.
4. Certification Pathways: filter by provider, role and level. Set a demo learning status. Open official provider requirements.
5. Work Log: submit a June entry with squad, task, evidence and next action. Mentor Reviews: assess five categories and record an assessment phase. Leadership Insights reflects those local changes.

## Engineering and mentor checks
- Five-area weights: 25/25/20/15/15. All 4/5 ratings yield 80/100. Proposed threshold also requires each rating >=3 and three evidence checks. This yields Ready for panel, not a qualification award.
- Existing six-area assessments retain their original score calculation and are labeled legacy.
- Existing module progress and logs are retained in the same browser-storage key. Prior day progress is archived before the new 30-day roadmap starts; archive visible on Overview and in JSON export.
- New records include assessmentGate/rubric, squad/task/nextAction, credential statuses, phase milestones and solution status.
- Shared module/resource data remains in dist/data.js. Roadmap, domains and credential metadata are in dist/transformation-data.js. No duplicate resource catalog is created.
- Reset intentionally restores sample data; JSON export is the only backup/download function. No import or server recovery exists.

## Verified credential editorial policy
Official provider pages checked 24 November 2026 and linked per card. AI-103 is Azure AI Apps and Agents Developer Associate; AI-200 is Azure AI Cloud Developer Associate; AB-730 is AI Business Professional. GitHub Copilot GH-300 and Actions GH-200. SnowPro Core COF-C03. AZ-305 requires Azure Administrator Associate for the Expert credential. Databricks labels beginning DB- are local catalog IDs, not provider exam codes. OpenAI course badges are learning-only. Windows and Essential/Role-specific/Advanced labels are academy guidance, not provider mandates. Reverify before booking; no exam fee/availability guarantee is made.

## Functionality boundary
Working: navigation, resource expansion, local work-log CRUD, weighted review records, personal progress, filters, self-reported credential/squad status and computed leadership summaries.
Demo: profiles, all participant records, squad maturity, credentials and readiness decisions. No real agents, customer pilots, multi-user backend, identity verification, notifications or live cloud analytics.
Future: Entra ID with Participant/Mentor/Program Admin/Leadership roles; API authorization on every operation; Azure SQL migrations; audit and privacy controls; managed identities; Azure frontend/API deployment. Existing draft schema and API contract are an earlier starting point, not applied migrations or a complete implementation of these new fields. Add versioned assessments, phase milestones, credential evidence and squad solution records before rollout. Never trust browser-assigned roles or self-reported certification status as authorization/evidence.
