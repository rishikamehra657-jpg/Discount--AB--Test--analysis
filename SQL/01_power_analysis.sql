-- Step 1: Power Analysis
-- Purpose: Calculate baseline conversion rate to determine required sample size
-- before looking at any experiment results

SELECT
    COUNT(*) as total_control_users,
    SUM(conversion) as total_conversions,
    ROUND(AVG(conversion) * 100, 3) as baseline_conversion_rate_pct
FROM criteo_raw
WHERE treatment = '0';

-- Result: 2,096,937 control users, 4,063 conversions, 0.194% baseline rate
-- Power analysis (evanmiller.org, MDE=10%, alpha=0.05, power=80%):
-- Required sample size = 819,594 per group
-- Actual samples (2,096,937 control / 11,882,655 treatment) far exceeded requirement