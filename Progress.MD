\## Covered \& understood

\- Hashing vs encryption (one-way / two-way, salting, why MD5 broken)

\- JWT (header.payload.signature, base64 not encrypted, server secret = signature)

\- Bearer token auth, login flow end to end

\- HTTP request anatomy (method, path, headers, body)

\- 500 = server fault, 401 = who are you, 403 = you can't, 200 = ok

\- Rainbow tables — cracked 12345 MD5 instantly on crackstation

\- Salt — random per-user string added before hashing, defeats rainbow tables

\- HTTP methods: GET, POST, PUT (replace whole), PATCH (partial), DELETE

\- Idempotency: GET/PUT/DELETE always idempotent; POST never; PATCH depends on payload (absolute=yes, increment=no). Double-submit = POST double-charge risk (real test case)

\- 401 vs 403 nailed: 401 = authentication fails (don't know who you are); 403 = authenticated but not permitted (keycard scans, not on the list). Got a real 403 hitting /administration as normal user

\- Docker port mapping: \`-p HOST:CONTAINER\`, Juice Shop always listens on 3000 inside container, run \`docker run --rm -p 8080:3000 bkimminich/juice-shop\`. \`-d\` = detached, \`docker ps\` lists running containers + port map, \`docker stop <id>\`



\## Setup facts (confirmed)

\- Juice Shop runs in Docker on \*\*http://localhost:8080\*\* (NOT 3000 — that's the roadmap's default; his mapping is ~2800–3010)

\- Postman: not installed yet

\- GitHub: no repo yet. \*\*Wants to learn GitHub basics + CLI too\*\* — fold into Stage F/Z.



\## To dig deeper / quiz me on

\- HTTP methods: GET ✓ / POST ✓ covered. PUT/PATCH/DELETE + idempotency = NEW (as of this session)

\- GitHub basics + CLI (git add/commit/push, clone, branches, PRs, gh cli) — newly requested

\- Status codes full set

\- DevTools Network tab practice

\- Postman collection build

\- SQL daily drills



\## Git (M1) — session covered

\- Three zones: working dir → (git add) → staging → (git commit) → local repo → (git push) → GitHub ✓

\- commit saves ONLY staged changes; understood why (selective/logical commits) ✓

\- Ran full loop manually: status → add → commit → log --oneline → push ✓

\- fetch vs pull: fetch downloads, pull = fetch+merge; use pull when remote is ahead (hit this live — GitHub had initial commit local didn't) ✓

\- Reads \`HEAD -> main, origin/main\` on same commit = in sync ✓

\- Commit message hygiene noted (his log a bit messy: test/progress.md/upload)

\- Branches ✓: switch -c, working dir is repainted per branch (file "gone" = not in main's snapshot; commit lives in .git), merge folds commits in, branch→PR→merge lifecycle ✓

\- Conflicts ✓: overlapping edits to same lines git can't auto-resolve (NOT old-vs-new) ✓

\- M1 GIT effectively DONE (more than basics now). TODO later: .gitignore, GitHub Issues as bug tracker (→ M9), gh CLI

\- RE-QUIZ: 401 vs 403 slipped this session then re-corrected (403 = user7→user8 / normal→admin). Quiz again next open.



\## Bugs found so far (Juice Shop)

\- MD5 used for password hashing (crackstation cracked it instantly) — critical

\- Password hash exposed in JWT payload — unnecessary data exposure

