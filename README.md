Does a Discount Actually Win Customers, or Just Attract Deal Seekers?

An A/B test analysis using real ad-conversion data from Criteo, built with SQL and Power BI.

The question I wanted to answer

Companies run discount campaigns all the time and just look at whether conversions went up. But that's not the full picture — if the discount mostly attracts people who were going to buy anyway, you're not gaining new customers, you're just giving away margin for free. I wanted to actually test that, properly, using real experimental data instead of assuming the answer.

The data

I used the Criteo Uplift Modeling dataset — a real randomized experiment run by Criteo, a large digital advertising company. It has about 13.98 million rows, where users were randomly split into a treatment group (shown an ad/offer) and a control group (not shown one), along with whether they converted.

I didn't use Python anywhere in this project — everything is SQL (SQLite) for the analysis and Power BI for the dashboard, plus Excel for the business model.

How I approached it

I didn't just jump straight to "did conversion go up." I tried to run this the way an actual experiment should be checked:

1. Power analysis, before looking at any results. Before touching the outcome data, I calculated how big a sample I'd actually need to detect a meaningful lift. Based on the observed baseline conversion rate (0.19%) and a 10% relative minimum detectable effect, the calculation said I'd need at least ~820,000 users per group. The actual experiment had 2.1M in control and 11.9M in treatment — comfortably powered.

2. Checked the sample split wasn't broken. The split between groups was roughly 15% control / 85% treatment, not 50/50. That's not a red flag by itself — it just means Criteo intentionally allocated traffic that way — but I checked it explicitly instead of assuming randomization worked.

3. The actual test: did the discount move conversion? Control converted at 0.19%. Treatment converted at 0.31%. That's a 59.4% relative lift, and it's statistically significant (p < 0.001, 95% CI on the lift: 55.9%–62.9%). So yes — this isn't noise, the discount really did move behavior.

4. Dug one layer deeper. Within the treated group, I looked at whether people who were actually shown the ad (not just eligible for it) behaved differently. They converted at 5.38% versus 0.12% for those not shown — a huge gap. But I want to be upfront about this one: exposure wasn't randomly assigned, it was decided by an ad auction. So this is most likely the auction picking out higher-intent users, not proof that seeing the ad causes a 45x jump in conversion. I'm treating it as a descriptive pattern, not a causal finding, and I've flagged that clearly on the dashboard too.

5. Translated it into money. The dataset doesn't include order values, so I used a reasonable assumption — ₹500 average order value, 10% discount — and built a simple revenue model comparing "never ran the discount" against "ran it for everyone." Even after paying out the discount to every extra converter, running the campaign still came out meaningfully ahead in net revenue. (Exact numbers are in the Excel file and on the dashboard.)

What I found, in short
The discount genuinely works — it's not just pulling in people who'd have converted anyway. Real, statistically significant lift.
But the picture isn't uniform underneath that headline number — the exposure pattern is a good example of why you shouldn't stop at the top-line result.
Financially, running it was worth it even after accounting for the cost of the discount itself.
Dashboard

Three panels, built in Power BI:

Conversion funnel — control vs treatment, with the statistical validation (lift, p-value, confidence interval) right on the panel
Segment breakdown — the exposure pattern, with the causal caveat included directly on the dashboard, not hidden in a footnote
Business impact — the two rollout scenarios and the net revenue difference

(Screenshots below — see /outputs folder)


What I'd do differently / limitations
The dataset doesn't label features f0–f11, so I couldn't build a "real" customer segment (like frequency or spend tier) — I used exposure instead, since it's the one column with an actual documented meaning.
Revenue numbers rely on an assumed AOV, not real pricing data — clearly labeled as an assumption, not observed fact.
The exposure-based finding is descriptive, not causal — worth remembering if this comes up in conversation.
Tools used
SQL (SQLite) — all analysis, no Python
Power BI — dashboard
Excel — business impact model
