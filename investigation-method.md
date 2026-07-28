# The Core Tester Move — repeatable procedure

Run this on any misbehaving feature. It's the loop that produced the basket bug chain.

---

## The 7 steps

**0. PREDICT first.** Before opening anything, write down the status code and behavior you *expect*. Being wrong is the point — it forces retrieval and shows you where your model is off.

**1. Open DevTools → Network. Tick "Preserve log."** Without it, a page navigation or redirect wipes the evidence you're about to need.

**2. Filter to the API.** Click **XHR / Fetch-XHR**, then type `rest` or `api` in the free-text filter box. (Remember socket.io polling is a legitimate XHR and survives the filter — the text box is what kills it.)

**3. Do the thing that breaks.** Perform the action. Watch requests appear in real time.

**4. Read the request:**
- **Method** — is it the right verb for the job?
- **Path** — is every parameter sane? *(this is where `NaN` was hiding)*
- **Request headers** — is `Authorization: Bearer …` present when it should be?
- **Payload/body** — is the app sending what you actually typed?

**5. Read the response:**
- **Status code** — compare against your prediction. Does it match the 4xx pipeline?
- **Response body** (the *Response* tab, NOT the *Headers* tab) — does it agree with the status, or contradict it?
- ⚠ **A status and body that disagree is itself a bug.**

**6. Check the Console tab.** Any JS error? Find the topmost line that's **app code, not framework** (`main.js` vs `chunk-*.js` / `polyfills.js` / `node_modules`). That's the culprit — file and line.

**7. State the user impact.** Not "it returns null" — *"the basket is dead, so nobody can check out."* Impact drives severity.

---

## Report format

```
FEATURE:        what you were testing
ACTION:         exactly what you did (literal steps)
PREDICTED:      the status/behavior you expected before looking

REQUEST:        METHOD /path
                notable headers / payload
RESPONSE:       status code
                body
CONSOLE:        any error + the app-code line

MISMATCH:       what's wrong, and what it SHOULD have been (justify via the pipeline)
IMPACT:         what a real user loses
SEVERITY:       + one line of reasoning
SEPARATE BUGS?  is this one defect or several with different owners/fixes?
```

---

## Reminders

- **Status ≠ body.** Read both. Their disagreement is a finding.
- **Two-bug test:** could you fix the frontend and still have the backend accept garbage? Then it's two bugs.
- **Don't over-report.** `Secure: false` on localhost is noise. Credibility is a finite resource.
- **Copy as cURL** (right-click a request) — attach it to bug reports so a dev can reproduce instantly, no clicking required.
