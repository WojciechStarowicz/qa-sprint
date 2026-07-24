# Web QA/Tester — A to Z (2-week sprint, ~40 hrs, go at your own pace)

Built around the company's actual list. Work top to bottom — each stage builds on the last.
Hour estimates are rough; grind them in whatever chunks suit you (weekend marathons are fine).

**The one exception to "linear": SQL.** It's the only skill here that *cannot* be crammed in a marathon — syntax recall is spaced repetition. **20–30 min every single day, no matter what stage you're on, starting today.** Everything else is A→Z.

---

## ☐ The daily constant — SQL (20–30 min/day, all 14 days)

- ☐ Days 1–5: [SQLBolt](https://sqlbolt.com) start to finish. Type everything, no AI.
- ☐ Days 6–14: 3–5 problems/day on sql-practice.com or PostgreSQL Exercises.
- ☐ Cold-recall targets: SELECT + WHERE (AND/OR, IN, BETWEEN, LIKE, IS NULL), ORDER BY, LIMIT, DISTINCT; COUNT/SUM/AVG + GROUP BY + HAVING (and why HAVING exists); INNER vs LEFT JOIN (what LEFT returns on no match); simple subqueries; UPDATE/DELETE with WHERE written *first*.
- ☐ Memorize execution order: `FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY`.
- ☐ Interview framing if asked: "I write and verify standard queries myself; still building speed on complex ones." Honest, and it meets their bar.

---

## Stage A — Setup (~2 hrs)

- ☐ Install Docker Desktop, run Juice Shop: `docker run --rm -p 3000:3000 bkimminich/juice-shop` → http://localhost:3000. This app is your playground for *every* stage below.
- ☐ Install Postman.
- ☐ Create a GitHub repo `qa-portfolio` with GitHub Issues enabled (your bug tracker) and a README you'll fill as you go.

## Stage B — HTTP fundamentals (~4 hrs) *(their points 2 & 3)*

- ☐ Methods and their intent: **GET** (read, no side effects), **POST** (create), **PUT** (replace whole resource), **PATCH** (partial update), **DELETE**. Know PUT vs PATCH and the word *idempotent* (same call twice = same result: GET/PUT/DELETE yes, POST no).
- ☐ Status code families: 2xx success, 3xx redirect, **4xx client's fault, 5xx server's fault**.
- ☐ The ~12 codes to know cold: 200, 201, 204, 301/302, 400, **401 vs 403** (401 = "who are you?", 403 = "I know who you are — you're not allowed"), 404, 409, 422, 429, 500, 502, 503.
- ☐ Anatomy of a request/response: URL, method, headers, body; response status, headers, body. What `Content-Type: application/json` means.
- ☐ Quick check on the "you already know this" items: JSON structure (objects, arrays, nesting) and what a UUID is (globally unique ID, format `8-4-4-4-12` hex). Confirm, move on.

## Stage C — Browser DevTools debugging (~6 hrs) *(their point 1 — likely their biggest daily-work item)*

All hands-on against Juice Shop. Open DevTools (F12) → **Network tab** and live there:

- ☐ Click around the app watching requests fire. For each: method, status, timing.
- ☐ Open one request fully: request headers, payload, response body. Find the JWT token in the `Authorization` header after logging in — connect this to Stage D.
- ☐ Filter by Fetch/XHR to see only API calls. This is how you separate "the API broke" from "the frontend broke."
- ☐ Practice the core tester move: make the UI break (wrong login, weird input), then find the failing request and read *why* from the status code + response body. Do this 10+ times until it's reflex.
- ☐ Learn: right-click a request → **Copy as cURL** (gold for bug reports), and the **Preserve log** checkbox (keeps requests across page navigation).
- ☐ Console tab: spot JS errors, read what file/line they point to.
- ☐ Application tab: find cookies, localStorage — where the session actually lives.
- ☐ Throttling: simulate slow 3G, see what breaks.

## Stage D — HTTP auth basics (~3 hrs) *(their "podstawy komunikacji http / uwierzytelnianie")*

Recognize-and-explain level, not implement:

- ☐ **Basic auth** (base64 user:pass in a header — legacy, insecure without HTTPS).
- ☐ **Bearer tokens / JWT** (`Authorization: Bearer eyJ...`) — the modern default. Decode a real JWT at jwt.io (grab one from Juice Shop DevTools): header, payload, signature. Know it's *signed, not encrypted* — anyone can read the payload.
- ☐ **Cookies + sessions** — server-side state, cookie is just the key; what HttpOnly/Secure flags mean at a glance.
- ☐ **API keys** — a static secret in a header or query param.
- ☐ **OAuth2** — one paragraph deep: "the protocol behind Login-with-Google; app gets a token without ever seeing your password."
- ☐ Tie-back: this is *why* 401 vs 403 matters, and it's what you're literally watching in the Network tab.

## Stage E — Postman / direct API requests (~4 hrs) *(their point 4)*

- ☐ Recreate in Postman what you saw in DevTools: hit Juice Shop's API directly. Log in via POST, copy the token, use it as Bearer auth on authorized endpoints.
- ☐ Build a small collection: at least one GET, POST, PUT/PATCH, DELETE.
- ☐ Negative tests: no token (expect 401), malformed body (expect 400), someone else's resource (expect 403/404).
- ☐ Use an environment variable for the base URL and token (basic Postman hygiene interviewers notice).
- ☐ Export the collection → your repo.

## Stage F — Writing scenarios, bugs & user stories (~6 hrs) *(their points: scenariusze testowe + rozpisywanie tasków)*

- ☐ Write **10–15 test scenarios** for one Juice Shop feature (login or basket). Simple table: ID, title, preconditions, steps, expected result. Mix positive and negative cases. Save to repo.
- ☐ Execute them; log **5+ real bugs** as GitHub Issues, each with: clear title, environment, **steps to reproduce**, expected vs actual, severity + priority (know they're independent), screenshot, and — your differentiator — the failing request from DevTools (status code + copied cURL).
- ☐ Write **5 user stories** ("As a…, I want…, so that…") each with **Given/When/Then acceptance criteria**. This is the PO half. Save as `backlog.md`.
- ☐ Do one 60-min **exploratory session** with a written charter + notes (name-drop "session-based testing").

## Stage G — Reading logs (~3 hrs) *(their point 6)*

- ☐ Run Juice Shop with visible logs (`docker logs -f <container>`), click around the app, and watch your own requests appear. Trigger errors on purpose and find them.
- ☐ Learn log levels: ERROR / WARN / INFO / DEBUG — and that you filter by level + timestamp first.
- ☐ Read a stack trace the practical way: **topmost line = where it blew up**, read downward for the call chain; find the first line mentioning the app's own code.
- ☐ Connect to what you know: correlationId/traceId is how you find *one request's* log lines across services. (You have the traceId/spanId/correlationId theory from before — refresh it here.)
- ☐ SQL tie-in: for 2 of your logged bugs, verify the data behind the UI with your own queries → `verification-queries.sql` in repo.

## Stage H — Grafana, conversational level (~2 hrs) *(not on their list — demoted, don't over-invest)*

- ☐ Be able to say: Grafana = visualization layer; it queries data sources (Prometheus = metrics, Loki = logs, Tempo = traces) and draws dashboards; QA uses it to watch environment health and load-test results.
- ☐ Spend 1 hr in the **Grafana Play** public sandbox: open a dashboard, click a panel, see the query behind it, find a trace waterfall and look at spans nesting.
- ☐ Only if you finish everything else early: the k6 load-test → Grafana dashboard build (it's a strong portfolio flex, but optional now).

## Stage Z — Package & interview prep (~4 hrs)

- ☐ Polish the repo README into a narrative: "Took Juice Shop → wrote scenarios → executed → found N bugs with network evidence → built a Postman collection → verified data in SQL." Link every artifact. This repo *is* your answer to "have you done testing?"
- ☐ One-breath explanations, out loud, for each: PUT vs PATCH · 401 vs 403 · idempotency · what you check first in the Network tab when a page misbehaves · JWT in one sentence · severity vs priority · what a good bug report contains · Given/When/Then (write one live) · LEFT vs INNER JOIN · why HAVING exists · traceId vs spanId vs correlationId · what Grafana does.
- ☐ Dry-run: have a friend (or me) grill you on the list above.

---

## Reality check / triage

Total ≈ **34 hrs + daily SQL** — fits 2 weeks at your pace with slack.
If you run out of time, the priority order matches their list: **DevTools (C) > HTTP (B) > Postman (E) > bugs/stories (F) > SQL (daily anyway) > logs (G) > auth (D) > Grafana (H)**. Grafana is the only safe full cut; auth can shrink to "JWT + 401 vs 403" if squeezed.
