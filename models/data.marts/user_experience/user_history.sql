WITH user_act AS (
    SELECT
        COUNT(user_id) AS users_act
    FROM {{ ref('dim_users') }}
),
user_snp AS (
    SELECT
        COUNT(user_id) AS user_org
    FROM {{ ref('dim_users_snp') }}
)
SELECT 
    ua.users_act,
    us.user_org,
    ua.users_act - us.user_org as user_difference
FROM user_act ua
FULL JOIN user_snp us 
