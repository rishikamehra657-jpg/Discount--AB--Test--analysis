-- Step 2: Sample Ratio Mismatch (SRM) Check
-- Purpose: Verify randomization worked as intended before trusting any results

SELECT
    treatment,
    COUNT(*) as total_users
FROM criteo_raw
GROUP BY treatment;

-- Result: Control = 2,096,937 users, Treatment = 11,882,655 users
-- ~15:85 split, matches Criteo's documented experimental design (not 50/50 by intent)
-- No unexplained skew detected -- randomization integrity confirmed