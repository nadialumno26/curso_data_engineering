WITH event_details AS (
    SELECT 
        session_id
        , user_id
        , MIN(created_at_utc) AS start_of_session
        , MAX(created_at_utc) AS end_of_session 
        , COUNT(DISTINCT page_url) AS pages_visited
        , COUNT(CASE WHEN event_type = 'page_view' THEN 1 END) AS page_view_events 
        , COUNT(CASE WHEN event_type = 'add_to_cart' THEN 1 END) AS add_to_cart_events
        , COUNT(CASE WHEN event_type = 'checkout' THEN 1 END) AS checkout_events
FROM {{ ref('fct_events') }} 
GROUP BY 1,2
ORDER BY 1 DESC, 6 DESC
)

SELECT
    ed.session_id
    , ed.user_id
    , u.first_name
    , u.last_name
    , ed.start_of_session
    , ed.end_of_session
    , DATEDIFF('hour', ed.start_of_session,ed.end_of_session) AS session_duration_hours
    , ed.pages_visited
    , ed.page_view_events
    , ed.add_to_cart_events
    , ed.checkout_events
FROM event_details ed
JOIN {{ ref('dim_users') }} u 
ON ed.user_id = u.user_id
WHERE 6 IS NOT NULL
ORDER BY 5
