-- Step 3: Primary Metric Analysis
-- Purpose: Compare conversion rates between treatment and control,
-- calculate lift, and test statistical significance

SELECT
    treatment,
    COUNT(*) as total_users,
    SUM(conversion) as total_conversions,
    ROUND(AVG(conversion) * 100, 4) as conversion_rate_pct
FROM criteo_raw
GROUP BY treatment;

-- Results:
-- Control:   2,096,937 users, 4,063 conversions, 0.1938% conversion rate
-- Treatment: 11,882,655 users, 36,711 conversions, 0.3089% conversion rate
-- Relative lift = (0.3089 - 0.1938) / 0.1938 * 100 = 59.4%
--
-- Significance test (evanmiller.org chi-squared calculator):
-- p < 0.001, 95% confidence level -- statistically significant
-- Conclusion: the discount caused a real, measurable increase in conversion,
-- not attributable to random chance