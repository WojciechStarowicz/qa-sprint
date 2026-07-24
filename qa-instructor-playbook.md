# QA/PO Sprint — Instructor Playbook

**Purpose:** This is Claude's teaching script, not a topic checklist. It sequences every skill by *prerequisite* so we stop hitting surprise gaps (Docker ports, git, PATCH idempotency all bit us because nothing said "teach this first"). Every module lists what must be true before it starts, what to teach, a hands-on Juice Shop task, exit criteria, and a quiz bank to pull from.

**Learner:** Wojciech. Technically capable (background in tech-adjacent corporate work, lots of "workarounds"), but new to *formal* testing. Making the jump into a junior Web QA + Product Owner role. Two weeks, ~4 hrs/day + full weekends (~34 hrs core + daily SQL). Learns best hands-on, Socratic, one step at a time. Wants to be tested and pushed, not lectured at.

**Practice target:** OWASP Juice Shop in Docker at **http://localhost:8080** (`docker run --rm -p 8080:3000 bkimminich/juice-shop`; app always listens on 3000 inside the container).

**Emphasis (his choice):** Match the company's real skill list — DevTools + HTTP + Postman + SQL + logs heaviest; PO/test-writing solid; Grafana light. Theory at **practical junior level** (apply it and speak fluently; no exam cramming).

---

## How Claude runs each session

1. **Open by re-quizzing.** Before any new material, pull 2–4 questions from the spaced-recall bank — weighted toward the *previous* session and one older callback. This is the retention check he asked for. If he misses one, reteach it briefly before moving on.
2. **Teach one concept, then make him DO something.** Never dump theory. Explain briefly → hands-on task on Juice Shop → check understanding with a question before advancing.
3. **One step at a time.** Do not advance to the next module until exit criteria are met.
4. **Slip in callbacks.** Weave older material into new contexts (e.g. when watching Network tab, ask about 401 vs 403).
5. **Update `Progress.MD` every session:** what's now solid, weak spots to re-quiz, bugs found. Keep the "quiz me later" list current.
6. **Be honest and push.** He explicitly prefers being tested hard over having gaps papered over. Correct misconceptions directly (the 403 "something wrong in the token" misconception is the model — name the wrong mental model, replace it).

**Legend:** ☐ = not started · ◐ = in progress · ✓ = solid (confirmed by quiz, not just covered)

---

## Prerequisite map (the spine)

```
M0 Environment (Docker, ports, terminal)
      │
M1 Git & GitHub + CLI ──────────────┐
      │                             │
M2 Web/HTTP mental model            │
      │                             │
M3 HTTP methods + idempotency       │
      │                             │
M4 Status codes (full set)          │
      │                             │
M5 HTTP auth (Basic/Bearer/JWT/     │
   cookies/API keys/OAuth2)         │
      │                             │
M6 DevTools (Network/Console/App) ──┤ ← biggest daily-work skill
      │                             │
M7 Postman / direct API requests    │
      │                             │
M8 Test theory (types, levels,      │
   STLC, case-design techniques)    │
      │                             │
M9 Test scenarios + bug reports ────┘  → all artifacts land in the git repo (M1)
      │
M10 User stories + acceptance criteria (PO half)
      │
M11 Reading logs (+ SQL data verification tie-in)
      │
M12 Grafana (conversational only)
      │
MZ  Portfolio packaging + interview grill

DAILY THROUGHOUT: SQL (20–30 min, spaced repetition — the one thing that can't be crammed)
```

Rule of thumb if time runs short (his priority order): **M6 DevTools > M3/M4 HTTP > M7 Postman > M9 bugs/stories > SQL (daily anyway) > M11 logs > M5 auth > M12 Grafana.** Grafana is the only safe full cut.

---

## M0 — Environment & terminal basics  ✓ (mostly done)
**Prereqs:** none.
**Teach:** Docker image vs container; `-p HOST:CONTAINER` mapping; `--rm` (deletes container on exit, image stays cached); `-d` detached; `docker ps` / `docker ps -a`; `docker stop <id>`; `docker logs -f <id>` (needed later in M11).
**Hands-on:** Start Juice Shop on 8080, confirm in browser, run `docker ps` and read the port column.
**Exit criteria:** Can start/stop Juice Shop unaided and explain the port mapping.
**Status:** Port mapping ✓, `--rm`/`-d` ✓, `docker ps` explained (not yet run). *Re-quiz `docker ps` output next session.*

---

## M1 — Git & GitHub + CLI  ☐ (newly requested)
**Prereqs:** M0 (terminal comfort).
**Why here:** every later artifact (scenarios, bug list, Postman export, SQL files) goes into a repo. Set the repo up *before* producing artifacts so there's somewhere to put them.
**Teach (practical, not exhaustive):**
- Mental model: working directory → staging area → commit → remote. The three-zone model is the thing people fumble.
- Core loop: `git status` → `git add <file>` → `git commit -m "msg"` → `git push`.
- `git clone`, `git pull`, `git log --oneline`, `.gitignore`.
- Branches: `git switch -c feature`, `git switch main`, merge/PR concept.
- GitHub: repo, README, **Issues as a bug tracker** (this is the QA hook), Pull Requests at a conceptual level.
- `gh` CLI: `gh auth login`, `gh repo create`, `gh issue create` — logging bugs from the terminal is a nice differentiator.
**Hands-on:** Create `qa-portfolio` repo (with Issues enabled), clone it, add a README, commit + push. Make one branch and one test Issue.
**Exit criteria:** Can go from edited file → committed + pushed without notes; can open a GitHub Issue.
**Quiz bank:** What are the three zones a change passes through? · Difference between `git fetch` and `git pull`? · What does `git add` actually do? · Why a `.gitignore`? · What's a PR *for* (not the mechanics — the purpose)?

---

## M2 — Web/HTTP mental model  ✓ (foundation solid)
**Prereqs:** none.
**Teach:** client↔server request/response; anatomy of a request (method, path/URL, headers, body) and response (status, headers, body); `Content-Type: application/json`; stateless nature of HTTP (→ motivates auth tokens in M5); JSON structure; what a UUID is (`8-4-4-4-12` hex, globally unique).
**Status:** Request anatomy ✓. *Confirm JSON + UUID in one quick pass, then move on — he has the technical background.*
**Quiz bank:** Name the parts of a request. · What does `Content-Type: application/json` tell the server? · What does "HTTP is stateless" mean and why does it force us to send a token on every request?

---

## M3 — HTTP methods + idempotency  ✓
**Prereqs:** M2.
**Teach:** GET (read, safe), POST (create/side-effect), PUT (replace whole resource), PATCH (partial), DELETE. Idempotency = repeating the call lands on the same end-state. GET/PUT/DELETE always idempotent; POST never; **PATCH depends on payload** (absolute value = idempotent; increment = not). Double-submit/double-charge is a POST problem and a real test case.
**Hands-on (deferred to M6):** identify GET vs POST live in the Network tab.
**Status:** GET ✓, POST ✓, PUT/PATCH/DELETE ✓, idempotency ✓ (incl. PATCH-depends-on-payload). Confirmed by quiz.
**Quiz bank:** Which method is idempotent-or-not depending on payload, and why? · Give an idempotent PATCH and a non-idempotent PATCH. · PUT vs PATCH in one line. · Why can double-clicking Pay charge twice?

---

## M4 — Status codes (full set)  ◐
**Prereqs:** M3.
**Teach:** Families — 2xx success, 3xx redirect, **4xx client's fault, 5xx server's fault**. The ~12 to know cold: 200, 201, 204, 301/302, 400, **401 vs 403**, 404, 409, 422, 429, 500, 502, 503.
**Hands-on (in M6):** trigger each family on purpose in Juice Shop and read it in Network tab.
**Status:** 200 ✓, 401 vs 403 ✓ (authentication vs authorization — nailed, incl. correcting the "something wrong in the token" misconception), 500 ✓. *Still to lock: 201 vs 204, 301 vs 302, 400 vs 422, 409, 429, 502 vs 503.*
**Quiz bank:** 401 vs 403 in one line using "identity" and "permission." · 4xx vs 5xx — whose fault? · Difference between 200, 201, 204? · What's 429 and when do you see it? · 502 vs 503? · You submit a form, server says 422 — what does that mean vs 400?

---

## M5 — HTTP auth  ◐
**Prereqs:** M2, M4 (401/403).
**Teach:** Basic auth (base64 user:pass, legacy, insecure sans HTTPS); **Bearer tokens / JWT** (`Authorization: Bearer eyJ...`, header.payload.signature, base64 = readable, *signed not encrypted*); cookies + sessions (server-side state, cookie is the key; HttpOnly/Secure flags); API keys (static secret in header/query); OAuth2 (one paragraph: the protocol behind Login-with-Google; app gets a token, never sees your password). Tie-back: this is *why* 401 vs 403 exists and what you watch in the Network tab.
**Status:** Hashing vs encryption ✓, JWT structure ✓ (header = alg metadata, payload = claims, signature = server-secret proof), Bearer flow ✓, `Authorization: Bearer` header format ✓, salting/rainbow tables ✓. *To cover: cookies/sessions + HttpOnly/Secure, API keys, OAuth2 one-paragraph, Basic auth.*
**Quiz bank:** Where does the JWT ride on a request and in what header format? · Is a JWT encrypted? What does that mean for the payload? · What does the signature prove? · What's HttpOnly protect against? · OAuth2 in one sentence. · Why is Basic auth risky without HTTPS?

---

## M6 — DevTools (Network / Console / Application)  ☐  ← THE big one
**Prereqs:** M3, M4, M5 (you must understand what you're looking at).
**Teach, all hands-on against Juice Shop, F12:**
- **Network tab first.** Click around; for each request read method, status, timing. Open one request fully: request headers, payload, response body. Find the JWT in the `Authorization` header after login (connects M5).
- Filter **Fetch/XHR** to isolate API calls — how you separate "API broke" from "frontend broke."
- **Core tester move (drill 10+ times):** break the UI (bad login, weird input) → find the failing request → read *why* from status + response body.
- Right-click → **Copy as cURL** (gold for bug reports). **Preserve log** checkbox (survives navigation).
- **Console tab:** spot JS errors, read file/line.
- **Application tab:** cookies, localStorage — where the session actually lives (ties to M5).
- **Throttling:** simulate slow 3G, see what breaks.
**Exit criteria:** Given a broken behavior, independently finds the failing request and explains the cause from status + body. Can copy a request as cURL.
**Quiz bank:** Page misbehaves — what's the first thing you check in Network? · How do you tell a frontend bug from an API bug? · Where does the session actually live in the browser? · What's "Copy as cURL" for? · What does Preserve log do and when do you need it?

---

## M7 — Postman / direct API requests  ☐
**Prereqs:** M3–M6 (recreate in Postman what you saw in DevTools).
**Teach:** Log in via POST, copy token, use as Bearer on authorized endpoints. Build a collection: ≥1 GET, POST, PUT/PATCH, DELETE. Negative tests: no token → 401, malformed body → 400, someone else's resource → 403/404. Environment variables for base URL + token (hygiene interviewers notice). Export collection → repo.
**Exit criteria:** A saved collection with positive + negative cases, using env vars, exported to the repo.
**Quiz bank:** Why use an environment variable for the token instead of pasting it? · What negative tests prove auth works? · What status do you *expect* from each negative test?

---

## M8 — Test theory (practical junior level)  ☐
**Prereqs:** none hard, but lands better after M6/M7 (real examples to attach it to).
**Teach (fluency + application, not ISTQB cramming):**
- **SDLC vs STLC** in a sentence each; where testing sits.
- **Test levels:** unit → integration → system → acceptance (UAT). Who does each.
- **Test types:** functional vs non-functional; smoke, sanity, regression, exploratory; performance/load, security, usability (recognize + define).
- **Static vs dynamic** testing (review a spec = static).
- **Case-design techniques (the money skill):** equivalence partitioning (one representative per class), boundary value analysis (test the edges — 0,1,100,101 for a 1–100 field; bugs cluster at boundaries), decision tables (combinations of conditions / business rules), state transition, error guessing.
- **Severity vs priority** — independent axes (a typo on the logo = low severity, high priority).
- **Bug life cycle:** New → Assigned → Open → Fixed → Retest → Closed / Reopened.
- **Verification vs validation** ("did we build it right" vs "did we build the right thing").
**Exit criteria:** Can pick the right design technique for a given field/rule and justify it; can define each test type in a sentence.
**Quiz bank:** For a "quantity 1–100" field, what values do you test and why? · When do you reach for a decision table? · Severity vs priority — give a high-priority/low-severity bug. · Smoke vs sanity vs regression? · Unit vs integration vs system vs UAT? · Verification vs validation?

---

## M9 — Test scenarios + bug reports  ☐
**Prereqs:** M6 (evidence), M8 (techniques), M1 (repo to store them).
**Teach:** Scenario table (ID, title, preconditions, steps, expected result), mixing positive + negative and applying M8 techniques. Anatomy of a great bug report: clear title, environment, **steps to reproduce**, expected vs actual, severity + priority, screenshot, and the differentiator — **the failing request from DevTools (status + copied cURL)**. Exploratory session with a written charter (name-drop "session-based testing").
**Exit criteria:** 10–15 scenarios for one feature (login or basket) + 5 real bugs logged as GitHub Issues with network evidence, in the repo.
**Quiz bank:** What makes a bug report reproducible? · Why attach the failing request? · What's in a scenario row? · What's a test charter?

---

## M10 — User stories + acceptance criteria (PO half)  ☐
**Prereqs:** M8 (shared vocab).
**Teach:** "As a…, I want…, so that…"; **Given/When/Then** acceptance criteria; INVEST qualities of a good story; splitting stories; the PO/tester overlap (acceptance criteria *are* test cases in disguise).
**Exit criteria:** 5 user stories with Given/When/Then, saved as `backlog.md` in the repo.
**Quiz bank:** Write a story + one Given/When/Then live. · What does INVEST stand for (loosely)? · How do acceptance criteria relate to test cases?

---

## M11 — Reading logs (+ SQL verification tie-in)  ☐
**Prereqs:** M0 (docker logs), M6 (correlate with requests), SQL (ongoing).
**Teach:** `docker logs -f <container>`, click app, watch your own requests appear; trigger errors and find them. Log levels ERROR/WARN/INFO/DEBUG; filter by level + timestamp first. Read a stack trace: **topmost line = where it blew up**, read down for the call chain, find first line in the app's own code. correlationId/traceId = find one request's lines across services (refresh his existing traceId/spanId/correlationId theory). **SQL tie-in:** for 2 logged bugs, verify the data behind the UI with your own queries → `verification-queries.sql` in repo.
**Exit criteria:** Can find the log lines for a request they just made and read a stack trace to the offending line.
**Quiz bank:** Which line of a stack trace do you read first? · Order the log levels by severity. · What's a correlationId for? · How would you confirm the DB actually saved what the UI claims?

---

## M12 — Grafana (conversational only)  ☐
**Prereqs:** M11 (logs/metrics/traces concepts).
**Teach (one paragraph + a sandbox poke):** Grafana = the **visualization layer**; it queries data sources and draws dashboards. **Prometheus** = metrics (time-series, PromQL, pull model). **Loki** = logs (label-indexed, LogQL). **Tempo** = distributed traces (request journey across services, spans). QA uses it to watch environment health and load-test results. Spend ~1 hr in **Grafana Play** public sandbox: open a dashboard, click a panel, see its query, find a trace waterfall and see spans nest. (Optional flex only if ahead: k6 load test → Grafana dashboard.)
**Exit criteria:** Can say in 3 sentences what Grafana is and name the metrics/logs/traces data sources.
**Quiz bank:** What does Grafana itself do vs its data sources? · Which source holds metrics, which logs, which traces? · What's a span?

---

## SQL — daily constant (every day, 20–30 min)
**Not a module — a habit.** Syntax recall is spaced repetition; can't be crammed.
- Days 1–5: SQLBolt start→finish, type everything, no AI.
- Days 6–14: 3–5 problems/day (sql-practice.com / PostgreSQL Exercises).
- Cold-recall targets: SELECT + WHERE (AND/OR, IN, BETWEEN, LIKE, IS NULL), ORDER BY, LIMIT, DISTINCT; COUNT/SUM/AVG + GROUP BY + HAVING (and *why* HAVING exists vs WHERE); INNER vs LEFT JOIN (what LEFT returns on no match); simple subqueries; UPDATE/DELETE with WHERE written *first*.
- Memorize execution order: **FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY**.
- Interview framing: "I write and verify standard queries myself; still building speed on complex ones."
**Daily quiz rotation:** difference between WHERE and HAVING? · what does LEFT JOIN return when the right side has no match? · write a query for [scenario] · what runs first, WHERE or SELECT?

---

## MZ — Portfolio packaging + interview grill  ☐
**Prereqs:** everything.
**Teach/Do:** Polish repo README into a narrative — "Took Juice Shop → wrote scenarios → executed → found N bugs with network evidence → built a Postman collection → verified data in SQL." Link every artifact. Then **one-breath, out-loud explanations** for: PUT vs PATCH · 401 vs 403 · idempotency · what you check first in Network when a page misbehaves · JWT in one sentence · severity vs priority · what a good bug report contains · Given/When/Then (write one live) · LEFT vs INNER JOIN · why HAVING exists · traceId vs spanId vs correlationId · what Grafana does · equivalence partitioning + boundary values.
**Final:** Claude runs a full mock interview and grades honestly.

---

## Master spaced-recall bank (Claude pulls 2–4 to open each session)

Weight toward *last session* + one older callback. Mark ✓ when answered cleanly twice on different days.

**HTTP/methods:** idempotency incl. PATCH-depends-on-payload ✓ · PUT vs PATCH ✓ · double-charge = POST ✓
**Status codes:** 401 vs 403 (identity/permission) ✓ · 4xx vs 5xx ✓ · 201 vs 204 ☐ · 429 ☐ · 422 vs 400 ☐ · 502 vs 503 ☐
**Auth:** JWT rides in `Authorization: Bearer` ✓ · signed-not-encrypted ✓ · signature proves tamper-free ✓ · HttpOnly ☐ · OAuth2 one-liner ☐
**Security findings:** MD5 broken / crackstation ✓ · salt defeats rainbow tables ✓ · why hash-in-JWT-payload is a bug ✓
**Docker:** `-p HOST:CONTAINER`, app on 3000 ✓ · `docker ps` output ☐
**Git:** three zones ☐ · fetch vs pull ☐ · what `add` does ☐
**Test theory:** EP + BVA on a range ☐ · severity vs priority ☐ · smoke/sanity/regression ☐ · test levels ☐
**PO:** story + Given/When/Then ☐ · INVEST ☐
**Logs:** stack trace top line ☐ · log levels order ☐ · correlationId ☐
**SQL:** WHERE vs HAVING ☐ · LEFT vs INNER JOIN ☐ · execution order ☐
**Grafana:** Grafana vs data sources ☐ · which source = metrics/logs/traces ☐

---

## Suggested 2-week flow (elastic — go at his pace)

- **Days 1–2:** M0 ✓ / M1 git / finish M4 status codes / start SQLBolt. *(M2, M3, most of M5 already done.)*
- **Days 3–5:** M5 finish auth / **M6 DevTools (spend big here)** / SQLBolt.
- **Weekend 1:** M6 drills + M7 Postman collection / SQL problems.
- **Days 6–8:** M8 test theory / M9 scenarios + bugs / SQL.
- **Days 9–10:** M10 user stories / M11 logs + SQL verification.
- **Weekend 2:** M12 Grafana / MZ portfolio polish.
- **Days 11–14:** buffer, re-quiz weak spots, full mock interview.

---

*Claude maintains this file and `Progress.MD` as we go. This playbook = the plan; Progress.MD = the running record of what's actually retained.*
