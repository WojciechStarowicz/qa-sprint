# Drill Sheet — cold-recall facts

Concepts you reason out fine. **This file is only the stuff that must be memorized.** Cover the right column, work down the left. 5 minutes, daily, alongside SQL.

Star ★ = you've missed this more than once. Priority.

---

## ★ Auth header formats (memorize verbatim)

| Prompt | Answer |
|---|---|
| ★ Send a JWT on a request | `Authorization: Bearer eyJhbGciOi...` |
| Send Basic auth | `Authorization: Basic <base64 of user:pass>` |
| Send an API key | `X-API-Key: abc123` (header) or `?api_key=abc123` (query — leaks into logs/history) |
| Server sets a session cookie | `Set-Cookie: sessionid=abc123` |

## ★★ JWT / token / Bearer — the in-depth untangle

**The single thing that keeps tripping you: the word "header" means TWO different things.**
Keep them in separate boxes:

```
BOX 1 — the HTTP request header (HOW you SEND the token)
────────────────────────────────────────────────────────
   Authorization: Bearer eyJhbGciOi.....
   └──── name ───┘ └scheme┘ └── the whole token ──┘

   • "Authorization"  = the name of the HTTP header line
   • "Bearer"         = the scheme ("the bearer of this token gets in")
   • eyJ...           = the ENTIRE token pasted in as one blob


BOX 2 — the token's OWN internals (WHAT the token IS)
────────────────────────────────────────────────────────
   eyJhbGci.aWQ6MjQ.HM44cs2
   └header─┘ └payload┘ └signature┘   ← 3 parts, split by DOTS

   • header    = which signing algorithm  {"alg":"RS256","typ":"JWT"}
   • payload   = the data / claims        {id, email, role, iat, exp}
   • signature = proof it's untampered
```

**They are NOT the same "header."** Box 1's header is the HTTP envelope line.
Box 2's header is the first slice of the token blob. Different layers.

### The 4 facts to have cold

1. **HOW it's sent:** `Authorization: Bearer <token>` — one HTTP header line. *(This is what you write in Postman / read in DevTools.)*
2. **WHAT it's made of:** `header.payload.signature`, joined by dots.
3. **It's SIGNED, not ENCRYPTED.** Each part is just **base64** = encoding, not encryption. Anyone can paste it into jwt.io (or `base64 -d`) and read the payload with **no key**. So the signature HIDES nothing.
4. **What the signature DOES:** proves **integrity + authenticity** — that *this server* issued it and nobody changed it. Edit the payload `role:customer`→`role:admin` and the signature no longer matches → server rejects it. That's its only job.

### Why the WHOLE token travels on EVERY request
HTTP is **stateless** — the server remembers nothing between requests, not even that you logged in one second ago. So each request must re-prove identity by carrying the entire token. "Logged in" is a UI illusion; the server only ever sees *"this request arrived with a valid token."* → send only a signature and there's nothing to verify against.

### Three "auth" words that blur together
| word | question it answers | code |
|---|---|---|
| authe**N**tication | who ARE you? | **401** |
| autho**R**ization | what may you DO? | **403** |
| authenticity (of the token) | did THIS server issue it, unaltered? | — (that's the signature's job) |

*N before R: authe**N**tication (401) comes before autho**R**ization (403), alphabetically, numerically, and logically — you prove who you are before what you can do.*

### Claims worth knowing
| claim | meaning |
|---|---|
| `iat` | issued-at (timestamp) |
| `exp` | expiry — **missing in Juice Shop's token ⇒ valid forever, and JWTs can't be revoked server-side** |
| `role` | what the payload claims you are (tamper target — see signature) |

## ★ Cookie flags

| Flag | Defends against |
|---|---|
| ★ `HttpOnly` | **XSS** — JavaScript cannot read the cookie |
| `Secure` | Sent only over **HTTPS** (meaningless on localhost) |
| `SameSite` | **CSRF** — controls sending on cross-site requests |

## Encoding vs encryption vs hashing

| Term | Key? | Reversible? |
|---|---|---|
| Encoding (base64) | none | Yes, by anyone |
| Encryption | yes, a key | Yes, with the key |
| Hashing | **no key exists** | **Never.** Server re-hashes input and compares hashes |

## Session vs JWT

| | Session | JWT |
|---|---|---|
| State | Stateful (on server) | Stateless (in token) |
| Revoke | Easy — delete the record | **Hard/impossible** until expiry |
| Scaling | Heavier (storage + lookup) | Scales well |
| Hijack risk | Lower | Higher (non-revocable) |

---

## ★★ Status codes — weakest area

| Code | Meaning | Hook |
|---|---|---|
| 200 OK | Success + body | "here's your data" |
| ★ 201 Created | Success, **new resource exists** | correct answer to a POST that creates; often + `Location` header |
| ★ 204 No Content | Success, **deliberately no body** | typical DELETE — "done, nothing to say" |
| ★ 301 | Moved **Permanently** | **cached** by browsers/search engines → painful to undo |
| ★ 302 | Found / **temporary** | not cached |
| ★ 400 Bad Request | **Malformed** — can't even parse | "I can't read this" |
| 401 Unauthorized | **Authentication** failed | "I don't know who you are" — card won't scan |
| 403 Forbidden | **Authorization** failed | "I know you, you're not allowed" — card scans, not on the list |
| 404 Not Found | No such resource | |
| ★ 409 Conflict | Clashes with current state | email already taken; concurrent edit |
| ★ 422 Unprocessable | **Well-formed but nonsense** | valid JSON, `email:"notanemail"`, `qty:-5` → "I read it fine, it's nonsense" |
| ★ 429 Too Many Requests | **Rate limited** | its **absence** during login brute-force = a finding |
| 500 Internal Server Error | App crashed / unhandled exception | "the code broke" |
| ★ 502 Bad Gateway | Proxy got a broken response from behind it | "the thing behind the proxy is broken" |
| ★ 503 Service Unavailable | Up but not serving — overloaded/maintenance | "alive but not accepting work" |

**Families:** 2xx success · 3xx redirect · **4xx client's fault** · **5xx server's fault**
*Why the split is actionable: 4xx → retrying the identical request is pointless, fix the request. 5xx → your request may be fine, a retry might work.*

---

### ★★ DERIVE, don't memorize — the 4xx pipeline

A server validates in stages. **The code marks how far you got before failing.**

```
1. Can I even parse this?          no → 400  Bad Request
2. Who are you?                    can't tell → 401  Unauthorized
3. I know you — are you allowed?   no → 403  Forbidden
4. Does the thing exist?           no → 404  Not Found
5. Are the values sensible?        no → 422  Unprocessable Entity
6. Do they clash with reality?     yes → 409  Conflict
7. Are you hammering me?           yes → 429  Too Many Requests
```

**★ The 422 vs 409 discriminator (was scrambled twice):**
> **Is the value wrong all by itself, or only wrong because something else exists?**
> - `quantity: -5` → wrong on its own, no other data needed → **422**
> - `email: taken@x.com` → a perfectly valid email! wrong *only* because another record has it → **409**
>
> **409 always involves a second thing** (existing record, concurrent edit). *Conflict* = two things colliding. Nothing to collide with ⇒ not 409.

**400 is upstream of both** — it never reaches value-judging because it can't *read* the request. Broken/truncated JSON = 400, always.

### ★ The 5xx rule — WHERE in the stack, not WHO wrote the code

```
Client → [ proxy / load balancer ] → [ app server ] → [ database ]
```

> **Is the broken thing *in front of* the app, or *is it* the app?**

| | |
|---|---|
| **500** | Request reached the app, app **ran**, its own code threw. *(A DB error counts — the DB is BEHIND the app, so the app crashed.)* |
| **502** | Proxy couldn't get a sensible response from **upstream**. App down/crashed/garbage. **No app code ran.** |
| **503** | Something is **up but refusing work** — overloaded or maintenance |

*Real-world caveat: all-backends-down returns 502 on nginx, but 503 on some load balancers (AWS ALB) that know there are zero healthy targets. 502 is the standard interview answer.*
*501 Not Implemented = server doesn't support the requested functionality/method. Rare — don't let it distract.*

### ★★★ SAVE ≠ CREATE (missed 3×) — the 201 trap
"We update and save" does NOT mean 201. **201 fires ONLY when a resource that didn't exist now exists.** PUT/PATCH to an EXISTING thing = you replaced/edited it = nothing born = **200**. The word "save" is irrelevant; the question is *did a new resource appear?*

### ★★ 501 vs 502 (keeps grabbing 501)
502 Bad Gateway = proxy couldn't get a valid response from the app behind it ("something before the app ran is down" = 502). **501 Not Implemented = server doesn't SUPPORT the request (unknown method)** — nothing to do with outages. If your reasoning is "the code didn't run," the answer is 502.

### ★ 200 vs 201 — the creation test
> **Did something that didn't exist before now exist?**
> PUT replacing an existing resource → nothing created → **200**. Only creation earns **201** (and that's why 201 carries a `Location` header — pointing at the newly-born thing).

### 3xx — the consequence follows from the meaning
301 permanent → *therefore* cacheable → *therefore* browsers/search engines remember → *therefore* painful to undo. 302 temporary → not cached. Don't memorize the caching separately; derive it.

---

## ★ Methods & idempotency

| Prompt | Answer |
|---|---|
| Whole resource | **PUT** |
| Only changed fields | **PATCH** (PA-r-T-ial) |
| ★ Idempotency depends on payload | **PATCH** — `{"bio":"hi"}` absolute = idempotent; `{"visits":"+1"}` = not |
| Always idempotent | GET, PUT, DELETE |
| Never idempotent | POST |
| ★ Why PUT is always idempotent | You send the **complete final state** — repeating lands in the identical place |
| Double-charge risk | POST (not idempotent) |

---

## REST / JSON / UUID

| Prompt | Answer |
|---|---|
| ★ The REST frame | **endpoint + method + body → status code + JSON response** |
| Path param | `/products/17/reviews` — **which** thing |
| Query param | `?rating=5` — **how** you want it |
| ★ Six JSON types | string, **number**, boolean, null, object, array *(number is the one you forget)* |
| Object vs array | object `{}` = **named** keys, order irrelevant · array `[]` = **numbered** positions, order matters |
| ★ Tell them apart in a viewer | Does it collapse? → container. Then: **numbered children = array, named children = object** |
| Path notation | `.name` = dot notation · `[0]` = bracket notation · formally **JSONPath** (`$.data[0].price`) |
| Path stops where | At the first **primitive** — can't step into a number/string/bool |
| null vs "" vs absent | present-but-empty · present-empty-string · not there at all — three different states |
| ★ UUID layout | 128-bit, 32 hex chars, **8-4-4-4-12** |
| Version char | First char of the **3rd** group (`4` = v4) |
| Variant char | First char of the **4th** group (8/9/a/b) |
| v4 carries | Pure random — **no timestamp, no machine info, no ordering** |
| ★ Sequential-ID vulnerability name | **IDOR** — Insecure Direct Object Reference |

---

## ★ Git

| Prompt | Answer |
|---|---|
| ★ Three **zones** | working directory → staging area → repository |
| ★ Three **commands** | `add` → `commit` → `push` |
| `fetch` | Downloads remote **commits**; working files untouched |
| ★ `pull` | fetch **+ merge**. Does NOT override — merging is the opposite |
| Merge conflict cause | Same lines changed differently on both sides (**age/timing irrelevant**) |
| ★ `git switch -c feature` does what to files | **Nothing.** New label at the current commit. Files only change when switching to a branch with different commits |
| `HEAD -> main, origin/main` same commit | Local and remote **in sync** — nothing to push or pull |
| `commit` saves | **Only what was staged** |

---

## Stack traces

| Prompt | Answer |
|---|---|
| Step 1 | Read the **top error message** (~80% of the answer) |
| Step 2 | Find the topmost line that's **app code, not library** |
| Step 3 | Ignore everything below it (framework plumbing) |
| Library folder names | `node_modules/` (Node) · `site-packages/` (Python) · `vendor/` (PHP/Go/Ruby) |
| Your job as tester | Recognize server-side error → copy top lines + app file:line into the bug report. **Not** to debug it |

## Judgment

| Prompt | Answer |
|---|---|
| Why `200 OK` + error in body is a bug | Automated clients check **status first** → treat the error as success. Silent failures, broken retries, monitoring blind |
| Why `Secure: false` wasn't reported locally | localhost is HTTP; `Secure` means "HTTPS only" → meaningless there. Real finding in production. **Knowing what not to report protects credibility** |
| Severity vs priority | Independent axes (typo on the logo = low severity, high priority) |
