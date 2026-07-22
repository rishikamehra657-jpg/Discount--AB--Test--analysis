-- Step 4: Segmentation Analysis (by Exposure)
-- Purpose: Within the treated group, check whether users who were
-- actually shown the ad converted differently from those who weren't

SELECT
    exposure,
    COUNT(*) as total_users,
    SUM(conversion) as total_conversions,
    ROUND(AVG(conversion) * 100, 4) as conversion_rate_pct
FROM criteo_raw
WHERE treatment = '1'
GROUP BY exposure;

-- Results (within treatment group only -- control has no exposure=1 users,
-- since control was never entered into the ad auction):
-- Not exposed (exposure=0): 11,454,443 users, 13,680 conversions, 0.1194%
-- Exposed (exposure=1):     428,212 users, 23,031 conversions, 5.3784%
--
-- IMPORTANT CAVEAT: exposure is NOT randomly assigned -- it's determined by
-- an ad auction, which likely prioritizes higher-intent users for exposure.
-- This large gap (~45x) is most likely a SELECTION EFFECT, not a causal
-- effect of ad delivery. Presented as a descriptive pattern, not a causal claim.