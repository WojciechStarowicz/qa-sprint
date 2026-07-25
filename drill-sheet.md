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

## ★ JWT anatomy

| Prompt | Answer |
|---|---|
| Three parts, separated by what | `header.payload.signature` — separated by **dots** |
| Header contains | The signing **algorithm** + token type: `{"alg":"RS256","typ":"JWT"}` |
| Payload contains | The **claims** / data (id, email, role, iat, exp…) |
| ★ Signature proves | **Integrity + authenticity** — server-issued and unaltered. Change `role:customer`→`admin` and it fails validation |
| Signature does NOT | Hide anything. Payload is readable by anyone (base64) |
| Encrypted? | **No — signed, not encrypted.** base64 = encoding |
| `iat` / `exp` | issued-at / expiry |
| No `exp` means | Token valid **forever** — and JWTs can't be revoked server-side |

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
