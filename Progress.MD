\# ▶ START HERE NEXT SESSION

\*\*Board:\*\* M0 ✓ Docker · M1 ✓ git · M2 ✓ REST/JSON/UUID · M3 ✓ methods · M4 ✓ status codes · M5 ✓ auth — \*\*entire foundation layer closed\*\*

\*\*Next:\*\* \*\*M6 — DevTools\*\* (biggest item on the company's list; Network/Console/Application tabs, the core tester move drilled 10+ times, Copy as cURL, Preserve log, throttling)

\*\*Open the session with these ★ misses (from the 31-question quiz):\*\*

1. \`Authorization: Bearer\` — exact format (was BLANK, had it 2 sessions ago)

2. What the JWT signature proves (said "user logged in" — it's integrity + authenticity)

3. Which method's idempotency depends on payload (said PUT — it's PATCH)

4. Three cookie flags + what each defends against (only recalled Secure)

5. Status codes: 201, 204, 400 vs 422, 429, 502 vs 503 (weakest cluster)

6. \`pull\` = fetch + \*\*merge\*\*, not override

\*\*⚠ NOT STARTED — SQL.\*\* Several days in and the daily 20–30 min hasn't begun. It's the one skill on their list that cannot be crammed. Start SQLBolt immediately, every day, no exceptions.

\*\*Also pending:\*\* \`drill-sheet.md\` — 5 min/day cold recall, cover right column. Chase the PARKED XSS thread during M6.



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

\- GitHub: \*\*repo created + working\*\* (clean history, push/pull/branch/merge all done manually by him). Prefers driving git himself — Claude coaches, does NOT take repo access.



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

\- RE-QUIZ: 401 vs 403 slipped then re-corrected (403 = user7→user8 / normal→admin).



\## Day-2 cold recall results (first no-notes test) — DECAY DATA

\*\*Held up ✓\*\*

\- Merge conflict cause — nailed incl. "older doesn't matter" nuance (was wrong before, now solid)

\- 401 vs 403 — CLEAN on cold recall. Consider this owned.

\- Staging specific files to control a commit

\*\*Partial ◐ (re-quiz)\*\*

\- Three zones: right shape, loose names. Drill: working directory → (add) → staging area → (commit) → repository → (push) → GitHub

\- fetch vs pull: thought fetch = "files I haven't modified". Correct: fetch downloads remote COMMITS, leaves working files alone; pull = fetch+merge

\*\*DECAYED — reteach + re-quiz hard ✗\*\*

\- \*\*Methods/idempotency regressed\*\* (was ✓ two sessions ago): called PATCH "the bulk one". PUT = whole/bulk, PATCH = partial. Had the "+1" instinct right but attached to wrong method. → Re-quiz every session until stable.

\- \*\*What travels on a request\*\*: said "only signature travels" — thought being "already logged in" means less is sent. Retaught: WHOLE JWT every request via \`Authorization: Bearer\`, because HTTP is STATELESS. "Logged in" is a UI illusion; server only sees "this request had a valid token." → Statelessness is the root concept to reinforce.

\- \*\*base64 = ENCODING not encryption\*\* (said "base64 encrypted"). JWT is signed-not-encrypted; signature prevents tampering, hides nothing.

\- \*\*Dismissed his own bug\*\*: said exposed hashed password "means nothing". Reconnected to the fact HE cracked MD5 12345 on crackstation instantly — hash exposure = offline cracking, no rate limit/lockout/alerts + password reuse. Must not talk himself out of this finding in an interview.

\*\*Teaching note:\*\* pattern = conceptual reasoning is strong (conflicts, 403, "+1" instinct), but \*terminology/labels\* slip (zone names, method names, encoding vs encryption). Quiz labels explicitly, not just concepts.



\## Post-reteach re-test (same session)

\- Statelessness ✓ (said HTTPS, corrected: HTTP is stateless; HTTPS = HTTP+TLS, adds privacy not memory)

\- base64 = encoding ✓ self-corrected. \*\*Three-way distinction taught:\*\* encoding (reversible by anyone) / encryption (needs key) / hashing (one-way, only guessable)

\- Signature = INTEGRITY (proves server-issued + untampered; edit payload to role:admin → signature mismatch → rejected). Not secrecy. ← was blank, now taught

\- Hash-leak rebuttal ◐ — gave sophisticated "depends on hashing method" (correct! MD5 vs bcrypt/argon2) but HEDGED instead of arguing. Push him to assert his own crackstation evidence.

\- \*\*SALT taught properly\*\* (he asked if salt leaking matters): salt is NOT secret, stored beside the hash by design. Job = make each hash unique so no shared rainbow table → forces per-hash attack. Salt defeats BULK precomputation; slow algorithm defeats TARGETED brute force. Salt leak ≈ minor.

\- \*\*PUT vs PATCH still fuzzy\*\* — named both, wouldn't assign which is which. Stated: PUT = whole resource, PATCH = partial. Mnemonic PA-r-T-ial. → RE-QUIZ EVERY SESSION until automatic.



\## M2 — REST / JSON / UUID (taught from scratch) — DONE

\*\*REST ✓\*\*

\- Frame: \*\*endpoint + method + body → status code + JSON response\*\* (ties M3/M4/M5/M7 together)

\- Resource = a "thing" with a URL; same noun, different verbs (GET/POST/PUT/PATCH/DELETE /users/42)

\- Path param (\`/products/17/reviews\` = WHICH thing) vs query param (\`?rating=5\` = HOW you want it) ✓ got both cold

\- DELETE /products/17/reviews/9 — skipped, was told

\*\*JSON ✓\*\*

\- 6 types: string (double quotes), number, boolean, null, object { }, array \[ ]

\- Object = named keys, order irrelevant. Array = numbered positions, order matters. "Array of objects" = most common response shape

\- Syntax: double quotes only, no trailing comma, keys always strings (\`{name:"x"}\` = valid JS, invalid JSON — the trap)

\- \*\*MISTAKE→FIXED:\*\* called the whole /api/Products response "array of objects". It's an OBJECT at top (\`status\` + \`data\` keys) containing an ARRAY under \`data\`. Cause: Firefox viewer hides outermost braces.

\- \*\*The tell (he half-derived it himself):\*\* only containers collapse → collapsible = container; then \*numbered children = array\*, \*named children = object\*

\- Paths: \`data\[0].name\` ✓ cold. Fixed \`data\[0].id.name\` misconception — dot notation only steps INTO containers, path terminates at a primitive

\- Naming: dot notation / bracket notation / the expression = a path / formal = \*\*JSONPath\*\* (\`$.data\[0].price\`) — used in Postman assertions

\- null vs "" vs key-absent = three different states, APIs behave differently. Good thing to probe.

\- Noticed Firefox shows single quotes when value contains double quotes — display artifact; real JSON escapes as \`\\"\`

\*\*UUID ✓\*\*

\- 128-bit, 32 hex chars, 8-4-4-4-12. Version digit = first char of 3rd group (\`4\`); variant = first char of 4th group (8/9/a/b) ✓ got version cold, variant needed prompt

\- v4 = random → NO timestamp, NO machine info, no ordering. \*\*Testing implication: can't sort by UUID for "newest first" — must sort by a real timestamp column\*\*

\- Purpose: unguessable (~5.3×10³⁶) + generatable anywhere without central coordination

\- \*\*Taught via contrast:\*\* Juice Shop uses SEQUENTIAL integer ids (1, 24, 6, 52) → enumerable → \*\*IDOR\*\* (Insecure Direct Object Reference), which is the user7→user8 / 403 story. UUIDs kill enumeration.

\*\*Also:\*\* first touch of DevTools \*\*Console\*\* tab (ran \`crypto.randomUUID()\`) — warm-up for M6



\## M4 — Status codes: taught + drilled live

\- 2xx: 200 "here's your data" / 201 "I made something" (+Location header) / 204 "done, nothing to say" (typical DELETE)

\- 3xx: 301 permanent (CACHED by browsers+search engines → painful to undo) vs 302 temporary (not cached)

\- 4xx: 400 "can't read this" (malformed) vs 422 "read it fine, it's nonsense" (well-formed, semantically invalid); 404; 409 conflict (email taken, concurrent edit); 429 rate limit — \*\*its ABSENCE during login brute-force is itself a finding\*\*

\- 5xx: 500 code broke (unhandled exception) / 502 thing behind the proxy is broken / 503 alive but not accepting work

\- \*\*Live drill:\*\* read real codes off Network tab — /api/Products 200 ✓, /api/Users 401 ✓, /api/ThisDoesNotExist 500 (BUG), /api/Products/99999 404 ✓ (correct behavior)

\- \*\*KEY LESSON (he tripped on it):\*\* first described the response BODY, not the status code. Taught: status comes from Network tab; body says WHAT, status says how machines interpret it — \*\*and when they disagree that's a bug\*\* (classic: 200 OK with an error in the body breaks every automated client)

\- \*\*Stack-trace reading taught early (M11 preview):\*\* top line = where it blew up; read down for call chain; \*\*find topmost line that's APP code not library code\*\* (\`build/routes/\` vs \`node_modules/express/\`) → pinpointed angular.js:52

\- Severity justification practiced: not High (no data loss/takeover) but > cosmetic; recon-aid class; priority > severity when fix is trivial



\## M5 — HTTP auth: COMPLETE

\*\*Unifying frame taught:\*\* HTTP is stateless ⇒ all 5 schemes answer ONE question — how do you prove identity on every request?

\- \*\*Basic auth\*\*: \`Authorization: Basic <base64 user:pass>\` — same header as Bearer, different scheme. base64 = encoding ⇒ plaintext password to anyone sniffing; sends the ACTUAL password every request (not revocable). Legacy/internal tools.

\- \*\*Sessions + cookies\*\*: server stores the session record, cookie carries only the KEY (a locker number, meaningless alone). Browser sends it automatically per-domain.

\- \*\*THE KEY TRADE-OFF (interview favorite)\*\*: session = STATEFUL, state on server, easy instant revocation (delete record), costs storage/lookup + harder to scale. JWT = STATELESS, data inside signed token, scales great, \*\*but cannot be easily revoked\*\* → why expiry times matter.

\- \*\*Cookie flags\*\*: \`HttpOnly\` = JS can't read it → anti-XSS. \`Secure\` = HTTPS only. \`SameSite\` = controls cross-site sending → anti-CSRF.

\- \*\*API keys\*\*: static secret identifying an APP not a user (\`X-API-Key\`). Static/no auto-expiry; in a query param it leaks into server logs + browser history (= a real finding).

\- \*\*OAuth2\*\*: the "Log in with Google" protocol — redirect to the provider, provider issues a scoped token, app never sees your password, access revocable. "Delegated access via tokens, not shared passwords."

\- \*\*Hands-on\*\*: found token in Application/Storage tab, read cookie flags, decoded own JWT payload via base64 (one command, no key — proving signed≠encrypted). Header showed \`alg: RS256\` (asymmetric).



\## 31-question thorough quiz (day 2, end of session) — RESULTS

\*\*Diagnosis: concepts strong, rote recall weak.\*\* Created \`drill-sheet.md\` for the memorization half. Do NOT keep re-explaining these — drill them.

\*\*Strong ✓\*\*

\- \#7 session vs JWT trade-off — excellent, unprompted (stateless/scales/hijack-prone vs stateful/heavier/safer)

\- \#11 path vs query param, \#17 PUT whole / PATCH partial (FINALLY locked), \#27 in-sync read, \#30 200-with-error-body, \#31 Secure-not-reportable judgment

\- \#9 encoding/encryption/hashing — good reasoning, needed sharpening (no key EXISTS in hashing; server re-hashes and compares)

\- \#25 merge conflict — was RIGHT but talked himself out of it. Confidence issue, not knowledge.

\*\*Conceptually wrong → corrected ✗\*\*

\- \#3 signature = "user logged in" ✗ → integrity + authenticity (role:customer→admin breaks it). ★ re-drill

\- \#18 said PUT depends on payload ✗ → PATCH. Fix taught: PUT = complete final state = always idempotent; PATCH = an instruction = can stack

\- \#24 "pull overrides stuff" ✗ → pull = fetch + MERGE (opposite of override)

\- \#26 thought branch creation moves files to .git ✗ → creates a label at current commit, files untouched

\- \#23 conflated zones with commands → 3 zones (working dir/staging/repo) + 3 commands (add/commit/push)

\*\*Blank / forgotten — pure memorization ★\*\*

\- \#6 \`Authorization: Bearer\` format — BLANK (had it 2 sessions ago). Highest priority drill.

\- \#2 JWT header contents (alg + typ) — blank

\- \#8 cookie flags — only recalled Secure; missing HttpOnly (anti-XSS!) + SameSite (anti-CSRF)

\- \#10 REST frame — blank

\- \#12 six JSON types — 5/6, missing \*\*number\*\*

\- \#15 UUID layout 8-4-4-4-12 — unsure

\- \#16 IDOR — knew the concept, not the name

\- \*\*STATUS CODES = WEAKEST CLUSTER\*\*: \#19 201/204 unsure, \#20 400/422 wrong (cross-wired 422 with the 404/500 path bug), \#21 500/502/503 blank, \#22 429 blank

\*\*Answered his question:\*\* \`data\[0].price.name\` → \`undefined\` in JS (no error); chain one more level → TypeError. Test tools just fail to match.

\*\*Also clarified:\*\* library folder names are canonical per ecosystem, not guesswork (node\_modules / site-packages / vendor)



\## PARKED — bug threads to chase later

\- \*\*Raw HTML inside product descriptions\*\* (\`<a href=...>\` in /api/Products). If rendered unescaped → injection/XSS vector. Chase in M6/M9.



\## Bugs found so far (Juice Shop)

\- MD5 used for password hashing (crackstation cracked it instantly) — critical

\- Password hash exposed in JWT payload — unnecessary data exposure

\- \*\*BUG A (correctness) — Unknown API route returns 500 instead of 404\*\* — \`GET /api/ThisDoesNotExist\` → 500. Client error (bad path) answered with server-fault code ⇒ no catch-all route; \`build/routes/angular.js:52\` throws "Unexpected path". Impact: wrong client semantics + false 500 alerts drowning real incidents. Fix: catch-all route returning 404. Severity Medium.

\- \*\*BUG B (security) — Full stack trace exposed in HTTP error response\*\* — same request returns Node/Express trace. Leaks: (1) absolute server paths \`/juice-shop/build/...\`, (2) tech stack = Express/Node, (3) internal module names incl. \`insecurity.js\` \& \`verify.js\`, (4) line numbers → version fingerprinting → CVE lookup. Class: error message containing sensitive info (recon aid, not direct exploit). Fix: suppress verbose errors in prod (\`NODE_ENV=production\` / proper error handler). Severity Medium, priority higher (trivial fix).

\- \*\*JWT has NO \`exp\` claim — token never expires\*\* (payload has \`iat\` only). Combined with JWT being stateless/non-revocable ⇒ a stolen token is valid FOREVER. Severity High.

\- \*\*Token cookie missing \`HttpOnly\`\*\* → readable by JavaScript. Also stored in \*\*localStorage\*\* (always JS-readable). Enables session hijacking via XSS.

\- \*\*\`totpSecret\` included as a token field\*\* — empty on this account, but if 2FA were enabled the 2FA seed itself would ship in the token ⇒ stealing the token also defeats two-factor. Design flaw.

\- \*\*NOT a bug (judgment practice):\*\* \`Secure: false\` on \`http://localhost\` — Secure means "HTTPS only" and there's no HTTPS locally. Would be a finding in production; reporting it here = noise. \*Taught: knowing what NOT to report protects credibility.\*

\- \*\*ATTACK CHAIN assembled\*\* (ties the whole day together): stored HTML/XSS in product description → script runs in victim browser → reads token from localStorage / non-HttpOnly cookie → exfiltrates → attacker replays token = full account takeover, no password, nothing in failed-login logs. Worse: no \`exp\` = works forever; payload MD5 hash → crack offline → password reuse elsewhere.

\- \*\*Filed as TWO bugs deliberately\*\* — different root causes, different fixes, different owners. Could fix the 404 and still leak traces elsewhere. (Taught: remediation-thinking vs symptom-listing.)

