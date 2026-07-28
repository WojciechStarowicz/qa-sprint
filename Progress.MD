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



\## Day 3 — Status codes RE-TAUGHT from first principles (his request: articulate, don't memorize)

\*\*Method note that worked:\*\* he asked to "reverse-engineer" rather than memorize. Taught the \*\*4xx pipeline\*\* (code = how far you got before failing) and the \*\*5xx location rule\*\* (where in the stack, not who wrote it). Both added to drill-sheet.md.

\*\*Key diagnostic:\*\* on the first scenario round his REASONING was correct every time but numbers attached wrong — on 409 he literally wrote "value is fine but clashing with database" and labelled it 422. \*\*Label-binding problem, not comprehension.\*\* Fix = give a discriminating question, not a definition.

\*\*Now solid ✓ (2nd round)\*\*

\- 400 — "automatic" per his own words, confident

\- 422 vs 409 — the discriminator landed: \*is the value wrong ALONE (422) or only because something else exists (409)?\*

\- 503 maintenance/refusing work · 429 · 201 vs 200 concept · 204

\- 500 when a DB error bubbles up — reasoned it out correctly while doubting himself (confidence gap again)

\*\*Still to re-drill ★\*\*

\- \*\*502 vs 500\*\*: called "load balancer up, all instances dead" a 500. Rule: broken thing IN FRONT of app = 502; app RAN and threw = 500. No app code ran ⇒ can't be 500.

\- \*\*200 vs 201\*\*: said PUT-update returns 201. Test = did something that didn't exist now exist? Update ≠ creation.

\- Kept inventing \*\*501\*\* as a distractor → defined it (Not Implemented) so it stops floating

\- Minor: called 422 "can't be parsed" — it DOES parse, it fails the VALUE check (that's the whole 400/422 split)

\*\*Confidence pattern worth noting:\*\* twice now he's reached a correct answer and then talked himself out of it (merge conflicts, 500-from-DB). Reasoning is more reliable than he believes. Tell him to commit to the answer.



\## M6 — DevTools (IN PROGRESS)

\- ★★ \*\*\`Authorization: Bearer\` FINALLY SEEN LIVE\*\* after 3 sessions of missing it on recall. Found on \`/rest/basket/...\`. Episodic encoding > flashcards — this is the fix that worked.

\- \*\*Cookie vs Authorization header — the real distinction taught:\*\* cookies are sent AUTOMATICALLY by the browser (no code) ⇒ that's exactly why \*\*CSRF\*\* exists and what \`SameSite\` defends. \`Authorization\` headers must be deliberately attached by JS ⇒ inherently CSRF-resistant (attacker can't make the browser add a header it doesn't know about).

\- Juice Shop is a HYBRID — carries the JWT in BOTH a cookie and the Authorization header.

\- \*\*XHR/Fetch filter\*\* ✓ used. Learned socket.io \`transport=polling\` legitimately IS an XHR (fake live connection over repeated XHR) so it correctly survives the filter → use the free-text \*\*filter box\*\* (\`rest\` / \`api\`) or right-click → Block, to cut noise.

\- Response \*\*Headers\*\* tab vs \*\*Response\*\* (body) tab — he conflated them twice; body is where the payload lives, \`Content-Length\` hints at size.

\- \*\*Applied the 4xx pipeline live and unprompted\*\* to argue NaN should be 400/404, not 200 ✓

\- \*\*Console tab ✓\*\* — read a live Angular TypeError, applied the app-code-vs-framework rule to it (\`main.js:225\` = app; \`chunk-*.js\` = RxJS stream, repeating \`next/_next\` is the tell; \`polyfills.js\` = zone.js runtime)

\- \*\*Minification taught\*\* — variable \`i\` is short because prod builds minify; source maps restore real names, and a team not shipping them is a fair thing to ask about

\- \*\*★ CORE TESTER MOVE COMPLETED END-TO-END (unaided):\*\* UI looks merely "empty" → Network shows malformed request + wrong status → Response body self-contradicts → Console shows the resulting crash → stated user impact. \*This is the M6 exit criterion, hit on the first real attempt.\*

\- TODO in M6: Copy as cURL, Preserve log, throttling, Application tab recap, and repeat the break-it→diagnose drill on other features (login, search, profile)



\## Solo investigations (M6, mostly unaided) — day 3

\*\*Inv 1 — failed login:\*\* \`POST //rest/user/login\` → \*\*401\*\*, body "Invalid email or password." Prediction (POST, /rest/, 401) MATCHED. Correct behavior, NOT a bug — vague message = deliberate anti-enumeration. \*Taught: "verified correct" is a valid, valuable result.\*

\- \*\*Untangled 4 confusions:\*\* (1) method = only the verb, REST is the style not a method; (2) POST≠201 — 201 only if something CREATED, login just processes → 200; (3) browser route \`/#/login\` (cosmetic, no request) vs API endpoint \`/rest/user/login\` (real HTTP) = two separate URL worlds; (4) path = noun hierarchy general→specific, verb never in the URL.

\- ★ \*\*401 keeps flipping to "authorization"\*\* — REDRILL. Hook that stuck: 401 authe\*N\*tication (who are you) comes before 403 autho\*R\*ization (what may you do), alphabetically AND numerically AND logically. Also: HTTP misnames 401 "Unauthorized" — mentally rename to "Unauthenticated."

\- Skill: find the right request via the \*\*Method column\*\* (scan for POST amid GET noise).

\*\*BUG (low) — double slash on every request\*\* \`//rest/...\`, \`//api/...\`. Base URL ends in / concatenated with path starting / . He guessed "root folder"; corrected. Impact: cache-key splitting, path-prefix rule/WAF bypass risk, log noise, protocol-relative-URL edge case. Report under minor observations. \*Skill shown: pattern-spotting across requests, not per-request.\*

\*\*Inv 2 — registration:\*\*

\- \*\*Botched first attempt\*\* (autofill replaced input) → self-corrected. \*Taught: "inconclusive" ≠ "no bug"; browser autofill/cached session/cookies are test-condition hazards; ALWAYS verify the Request payload — form shows what you think you typed, payload shows what was sent. Use incognito.\*

\- Clean retest (payload verified): \`POST //api/Users\`, duplicate email → \*\*400\*\*, body \`{"message":"Validation error","errors":\[{"field":"email","message":"email must be unique"}]}\`. Pipeline says 409 (valid value, collides w/ existing) but 400 is common/defensible → recognize, DON'T file (like Secure:false).

\- \*\*client-side validation caught \`notanemail\` (no request fired)\*\* → taught: client validation = UX not security, bypassable via Postman/curl → PARK for M7 (send \`notanemail\` straight to API, see if server also validates).

\- \*\*Weak password \`12345\` ACCEPTED\*\* — no complexity/length rule. Finding. (Plaintext pw in body over TLS = normal, NOT a bug — preempted.)

\- \*\*User enumeration (registration) — strong discussion:\*\* "email must be unique" confirms an account exists → build verified user lists from breach dumps, no password needed. Same threat login was hardened against ⇒ \*\*inconsistency\*\* is the real finding. He independently reasoned that a vague message doesn't help (binary outcome still leaks) → correct real-world fix = always-return-success + email out-of-band. Framed it as cost-raising not risk-elimination. Low severity, accepted-industry-issue, but flags nobody thought holistically.



\## Inv 3 — search (client-side filtering discovery)

\- Learned \*\*304 Not Modified\*\*: conditional GET via ETag → server says "unchanged, use cache", empty body in DevTools (don't mistake for "got nothing"). 3xx family now: 301 perm / 302 temp / 304 use-cache. Disable Cache off→on made 304s→200s (controlled experiment ✓).

\- Learned the Network log only captures while OPEN + \*\*Persist Logs\*\* (Firefox name for Preserve log) — hit the "No requests" empty-log problem, which is literally why the setting exists.

\- Free-text filter box (substring) vs type-filter row (All/HTML/XHR...). \`rest\` in the text box.

\- \*\*Discovery via hypothesis+evidence (well-run):\*\* expanding list 18→54 products fired ZERO new requests; searching \`banana\` after clearing log fired ZERO requests ⇒ \*\*entire catalogue preloaded, search/pagination are CLIENT-SIDE filtering\*\*, not server features. \`/rest/products/search?q=\` only called once on load.

\- \*\*BUG (frontend) — after F5 on a search URL, label says "Search results for apple" but request sends \`q=\` (empty)\*\* — displayed state ≠ real state; term not restored into the API call. Same family as basket NaN.

\- \*\*Finding (perf/design):\*\* \`application-configuration\` fetched 3× on one page load — redundant.

\- \*\*Finding (scale/design):\*\* client-side filtering works at 54 products, collapses at 50k (download/render/memory). + \*\*data-exposure principle: hiding in UI ≠ access control\*\* — whole catalogue is in the browser incl. \`deletedAt\` fields; deleted/hidden products may be one DevTools glance away. TEST LATER: does the preload payload contain non-null \`deletedAt\` items?

\- \*\*SQLi probe:\*\* \`?q='\` → 200 \`{"data":\[]}\`, no DB error → apostrophe handled as literal (parameterized/escaped). Taught: empty result ≠ proven safe; real payloads are \`' OR 1=1--\` not a bare quote; one negative probe doesn't clear an endpoint. (Security testing = beyond junior scope, but good instincts.)

\- \*\*Also note:\*\* Firefox "Edit and Resend" inspector view shows a \`{"GET":{scheme,host,filename,query}}\` shape — that's Firefox describing the request, NOT a server response. Don't confuse them.

\## Inv 4 — POST a feedback form (first POST-with-body drill)

\- POST \`//api/Feedbacks\` → \*\*201 predicted correctly\*\* (response proves creation: new \`id:11\` + \`createdAt\`). First confirmed 201 in the wild.

\- \*\*Read payload → found HIDDEN fields\*\* not in the form: \`captchaId\`, \`captcha:"-3"\`. Client sends both the challenge ID AND the answer ⇒ a CAPTCHA you can read+replay from the request doesn't stop automation. Weak anti-spam. (arithmetic captcha, trivially scriptable.)

\- \*\*Copy as cURL learned\*\* — copied CMD variant (\`^\` escaping, ugly); taught POSIX variant is cleaner for reports. KEY: the copied request had NO token cookie / NO Authorization header ⇒ explains earlier \`UserId:null\` — feedback submitted unauthenticated. \`X-User-Email\` present but that's a client hint, server rightly ignores for attribution. \*This is WHY cURL matters: full replayable request state.\*

\- \*\*Misconception corrected:\*\* typed \`DROP DATABASE\` in comment, nothing happened. Taught: SQL-in-a-text-field is NOT how you test SQLi; injection needs the server to CONCATENATE input into a query. Stored as literal string = safe handling. BUT the comment is saved + later displayed ⇒ real test is stored \*\*XSS\*\* (\`<script>...\`), park next to the descriptions thread.

\- \*\*BUG (he caught unprompted) — wrong CAPTCHA returns 401\*\* — captcha failure is not an authentication failure; should be 400/422. Status misuse, applied the pipeline himself.

\- \*\*M6 EXIT CRITERION MET\*\* — core tester move done end-to-end unaided across basket, login, registration, search, feedback.



\## SQL — JOINs (started)

\- Self-reported through SELECT/WHERE/aggregates/GROUP BY; at JOINs, theory hazy.

\- \*\*Model taught:\*\* foreign key = pointer between tables; JOIN follows it; \`ON\` says how rows correspond.

\- \*\*INNER vs LEFT ✓ concept\*\* — his "left table = source of truth" instinct correct. INNER = matches on both sides only; LEFT = keep ALL left rows, unmatched right side = \*\*NULL\*\*.

\- \*\*The NULL trick ✓\*\* — \`LEFT JOIN ... WHERE right.id IS NULL\` = "records in A with no counterpart in B" (never-ordered users). INNER can't answer it. Use \`IS NULL\` not \`= NULL\` (nothing equals NULL); test the KEY column not a nullable value column.

\- RIGHT JOIN = LEFT mirrored, rare.

\- \*\*KEY MISS to re-drill: row multiplication.\*\* Predicted INNER=4 (actual 6) and LEFT=6 (actual 8). A join yields one row per matching PAIR — Alice(2 orders)→2 rows, Dan(3)→3 rows. He counts users, not pairs. Reinforce.

\- Predictions on WHICH names/products were all correct; errors were counts + SQL typos (joined users to users; \`users.user\` vs \`users.id\`).

\- \*\*Setup fixed:\*\* blind write→I-run loop too slow. Chose \*\*Local SQLite\*\*. Recommended \*\*DB Browser for SQLite\*\* (GUI, grid view — suits his "can't picture tables from text"). Gave \`sql-practice.sql\` seed (users/products/orders/order_items with deliberate never-ordered users + never-sold product) in the repo. NEXT SQL SESSION: have him run the never-sold-product, per-product SUM, and 3-table join live; re-quiz row multiplication.



\## Day 4 open — 14-Q recall quiz

\*\*Clean ✓ (9/14):\*\* save≠create/200 (FINALLY solid), 401=authentication, JWT not-encrypted+base64, signature=integrity+authenticity (role:admin example), \*\*all 3 cookie flags + attacks\*\* (HttpOnly→XSS, SameSite→CSRF, Secure→HTTPS — used to be weak, now solid), PATCH idempotency, 422 vs 409, diagnosed own Postman Content-Type error, INNER row-count = 5 (row multiplication ✓).

\*\*Still missing ★:\*\*

\- \*\*502 vs 501 — STILL swapped\*\* (persistent). New hook given: "502 = Bad GATEWAY; gateway = the proxy/LB in front; scenario has load balancer/proxy/backend-down → 502. 501 = Not Implemented = feature not in code." Re-quiz next session.

\- \*\*Two-meanings-of-"header"\*\* (#5) — blank. This is the ROOT of his recurring \`Authorization: Bearer\` fuzziness. Re-explained: HTTP header line (\`Authorization:\`) vs token's internal first segment (header.payload.signature).

\- \*\*\`Authorization: Bearer <token>\` punctuation\*\* — wrote \`Bearer : token\` (extra colon). One colon, belongs to the header name.

\- \*\*Postman attach-token\*\* (#12) — blank though he DID it yesterday: Authorization tab → Bearer Token → paste.

\- #14 JOIN — concept ✓ but aimed at wrong table (orders vs order_items) + should test key column \`oi.id IS NULL\`.



\## PARKED — bug threads to chase later

\- \*\*Stored XSS\*\*: (a) raw HTML in product descriptions, (b) feedback comments are saved + redisplayed. Test \`<script>alert(1)</script>\` / \`<img src=x onerror=...>\` when we do a security pass. Only render-on-display confirms it.

\- \*\*Deleted-data exposure\*\*: check preloaded products payload for non-null \`deletedAt\`.

\- \*\*client-side validation bypass\*\* (from Inv 2): send \`notanemail\` etc. straight to API in M7 — does the server validate too?

\- \*\*Raw HTML inside product descriptions\*\* (\`<a href=...>\` in /api/Products). If rendered unescaped → injection/XSS vector. Chase in M6/M9.



\## M7 — Postman (in progress)

\- Built login POST by hand → captured token → attached as Bearer → opened protected endpoint. \*\*Authenticated to an API entirely outside the browser.\*\* (M7 core skill ✓)

\- \*\*Diagnosed own error:\*\* first login 401'd because Body dropdown was on Text not JSON → no \`Content-Type: application/json\` → server couldn't parse creds. Classic Postman mistake, now internalized.

\- \*\*Understood the tool:\*\* Auth tab just AUTO-WRITES the \`Authorization: Bearer\` header (no magic); the "n hidden headers" are Postman auto-adds (Content-Type, Accept, User-Agent: PostmanRuntime, Host, etc). Postman = organized way to send the SAME raw HTTP a browser sends; server can't tell them apart except User-Agent. When to use: browser = observe real-user behavior; Postman = send what the UI won't (missing/malformed/other-user/unsupported-method) to test the SERVER directly.

\- \*\*Negative test 1 — tampered token → 401\*\* ✓ predicted. Signature mismatch (RS256, signed with server's PRIVATE key; attacker can READ payload but can't FORGE a matching signature without the secret). Also noticed: \*\*error came back as HTML not JSON\*\* = minor format-inconsistency finding (JSON clients choke on it). Parked: alg:none / RS256→HS256 JWT bypass class for security pass.

\## Bugs found so far (Juice Shop)

\- \*\*BUG (MED) — No server-side input validation on registration\*\* — \`POST /api/Users\` with \`email:"notanemail"\` → \*\*201 Created\*\*, account id 25, \`Location: /api/Users/25\`. Browser blocks it client-side; server accepts garbage. Weak password \`12345\` also accepted (no complexity rule). Impact: junk accounts + breaks/abuses anything assuming valid emails (reset/verification). \*Proves definitively: client-side validation = UX only; if not enforced server-side it's not enforced. He can now assert this from his own evidence in an interview.\* Also confirmed textbook 201 behavior live: \`Location\` header points at the created resource.

\- \*\*BUG (HIGH/CRITICAL) — IDOR / Broken Access Control on \`GET /rest/basket/{id}\`\*\* — authenticated as user 24 (basket 6), requested \`/rest/basket/1\`, server returned 200 + full contents of user 1's basket (3 products, quantities). \*\*Authentication done, authorization SKIPPED\*\* — no "does this user own this basket?" check. Should be \*\*403\*\*. Combines with sequential integer IDs ⇒ trivially enumerable: \`for i in 1..N: GET /rest/basket/i\` harvests every basket. OWASP Top 10 #1. \*Found by him unaided via Postman — the two-step method: authenticate legitimately, THEN overreach. A broken token would've hidden it behind 401.\*

\- MD5 used for password hashing (crackstation cracked it instantly) — critical

\- Password hash exposed in JWT payload — unnecessary data exposure

\- \*\*BUG A (correctness) — Unknown API route returns 500 instead of 404\*\* — \`GET /api/ThisDoesNotExist\` → 500. Client error (bad path) answered with server-fault code ⇒ no catch-all route; \`build/routes/angular.js:52\` throws "Unexpected path". Impact: wrong client semantics + false 500 alerts drowning real incidents. Fix: catch-all route returning 404. Severity Medium.

\- \*\*BUG B (security) — Full stack trace exposed in HTTP error response\*\* — same request returns Node/Express trace. Leaks: (1) absolute server paths \`/juice-shop/build/...\`, (2) tech stack = Express/Node, (3) internal module names incl. \`insecurity.js\` \& \`verify.js\`, (4) line numbers → version fingerprinting → CVE lookup. Class: error message containing sensitive info (recon aid, not direct exploit). Fix: suppress verbose errors in prod (\`NODE_ENV=production\` / proper error handler). Severity Medium, priority higher (trivial fix).

\- \*\*JWT has NO \`exp\` claim — token never expires\*\* (payload has \`iat\` only). Combined with JWT being stateless/non-revocable ⇒ a stolen token is valid FOREVER. Severity High.

\- \*\*Token cookie missing \`HttpOnly\`\*\* → readable by JavaScript. Also stored in \*\*localStorage\*\* (always JS-readable). Enables session hijacking via XSS.

\- \*\*\`totpSecret\` included as a token field\*\* — empty on this account, but if 2FA were enabled the 2FA seed itself would ship in the token ⇒ stealing the token also defeats two-factor. Design flaw.

\- \*\*NOT a bug (judgment practice):\*\* \`Secure: false\` on \`http://localhost\` — Secure means "HTTPS only" and there's no HTTPS locally. Would be a finding in production; reporting it here = noise. \*Taught: knowing what NOT to report protects credibility.\*

\- \*\*ATTACK CHAIN assembled\*\* (ties the whole day together): stored HTML/XSS in product description → script runs in victim browser → reads token from localStorage / non-HttpOnly cookie → exfiltrates → attacker replays token = full account takeover, no password, nothing in failed-login logs. Worse: no \`exp\` = works forever; payload MD5 hash → crack offline → password reuse elsewhere.

\- \*\*BUG (frontend) — basket ID computed as \`NaN\`\*\* — app fires \`GET //rest/basket/NaN\` instead of \`/rest/basket/6\`. Correct id (\`bid: 6\`) is present in the user's own JWT. JS parse/arithmetic failure leaking into a URL. \*Found by him unprompted, purely from reading a request path.\*

\- \*\*BUG (backend) — \`/rest/basket/NaN\` returns \`200 OK\`\*\* with body \`{"status":"success","data":null}\`. Non-numeric ID should be \*\*400\*\* (unparseable param) or \*\*404\*\* (no such basket). \*\*The response contradicts itself 3 ways\*\*: HTTP 200 + body \`status:"success"\` + \`data:null\`. Silent failure — automated clients see 200 and proceed with nothing; no alert, no error log. \*Same "two bugs, different owners" split as the 404/500 pair: fixing the frontend still leaves the backend rubber-stamping garbage from Postman/mobile/attacker.\*

\- \*\*Noticed but NOT over-reported\*\* (judgment ✓): \`Access-Control-Allow-Origin: *\` on a user-data endpoint — real smell, but browsers won't send credentials to a wildcard origin, so less severe than it looks. \`X-Recruiting: /#/jobs\` = harmless easter egg.

\- \*\*Token cookie has neither \`HttpOnly\` nor \`SameSite\`\*\* ⇒ simultaneously stealable via XSS (JS can read it) AND usable via CSRF (auto-attached cross-site). Worst of both worlds in one cookie.

\- \*\*BUG (frontend) — unhandled null crashes basket render\*\* — \`TypeError: can't access property "Products", i is null\` at \`main.js:225\`. Frontend trusts the 200/"success" and dereferences \`data\` without a null check. \*\*Severity HIGH — purchase flow dead\*\* (basket empty, adding items does nothing ⇒ no checkout ⇒ no revenue). He identified the user impact unprompted = severity reasoning ✓

\- \*\*★ THE FULL CAUSAL CHAIN (his first complete end-to-end diagnosis):\*\* frontend sends \`NaN\` → backend rubber-stamps it \`200 {"status":"success","data":null}\` → frontend believes "success" → dereferences null → TypeError → basket dead. \*\*Proves the lying-200 isn't a style nit — it CAUSED the crash.\*\* A 404 would have hit the frontend's error path instead.

\- \*\*Filed as TWO bugs deliberately\*\* — different root causes, different fixes, different owners. Could fix the 404 and still leak traces elsewhere. (Taught: remediation-thinking vs symptom-listing.)

