# Create Database
#CREATE DATABASE spotify_product_analytics;

# Use Database
#USE spotify_product_analytics;


# PRODUCT KPIs
# Total Events
SELECT
    COUNT(*) AS total_events
FROM events;

# Average Listening Time
SELECT
    ROUND(AVG(minutes_played), 2) AS avg_minutes_played
FROM events;

# Average Engagement Score
SELECT
    ROUND(AVG(engagement_score), 2) AS avg_engagement_score
FROM events;

# Skip Rate
SELECT
    ROUND(AVG(skip_flag) * 100, 2) AS skip_rate_percentage
FROM events;

# ENGAGEMENT ANALYTICS
# Daily Listening Activity
SELECT
    DATE(ts) AS activity_date,
    COUNT(*) AS total_events
FROM events
GROUP BY activity_date
ORDER BY activity_date;

# Hourly Listening Activity
SELECT
    hour,
    ROUND(AVG(minutes_played), 2) AS avg_minutes
FROM events
GROUP BY hour
ORDER BY hour;

# Weekdays Vs Weekends
SELECT
    is_weekend,
    ROUND(AVG(minutes_played), 2) AS avg_minutes
FROM events
GROUP BY is_weekend;

 # SESSION ANALYTICS
 # Average Session Duration
 SELECT
    ROUND(AVG(session_duration), 2) AS avg_session_duration
FROM sessions;

# Average Tracks Per Sessions
SELECT 
    ROUND(AVG(tracks_per_session), 2) AS avg_tracks_per_session
FROM
    sessions;

# Highest Quality Sessions
SELECT
    session_id,
    session_duration,
    session_skip_rate
FROM sessions
ORDER BY session_duration DESC
LIMIT 10;

# PLATFORM ANALYTICS
# Platform Usage
SELECT
    platform,
    COUNT(*) AS total_events
FROM events
GROUP BY platform
ORDER BY total_events DESC;

# Platform Engagement
SELECT
    platform,
    ROUND(AVG(minutes_played), 2) AS avg_minutes
FROM events
GROUP BY platform
ORDER BY avg_minutes DESC;

# Platform Skip Rate
SELECT
    platform,
    ROUND(AVG(skip_flag) * 100, 2) AS skip_rate
FROM events
GROUP BY platform
ORDER BY skip_rate DESC;

# CONTENT ANALYSIS
# Top Artist
SELECT
    artist_name,
    COUNT(*) AS total_streams
FROM events
GROUP BY artist_name
ORDER BY total_streams DESC
LIMIT 10;

# Top Tracks
SELECT
    track_name,
    COUNT(*) AS total_streams
FROM events
GROUP BY track_name
ORDER BY total_streams DESC
LIMIT 10;

# BEHAVIOURAL ANALYSIS
# Engagement levels
SELECT
    engagement_level,
    COUNT(*) AS total_events
FROM events
GROUP BY engagement_level;

# Night Listening
SELECT
    night_listener,
    ROUND(AVG(minutes_played), 2) AS avg_minutes
FROM events
GROUP BY night_listener;

# Shuffle Usage
SELECT
    shuffle,
    COUNT(*) AS total_events
FROM events
GROUP BY shuffle;

# Shuffle Vs Engagement
SELECT
    shuffle,
    COUNT(*) AS total_events
FROM events
GROUP BY shuffle;

# FUNNEL ANALYSIS
# Simulated Funnel 
SELECT
    'Total Plays' AS funnel_stage,
    COUNT(*) AS users_count
FROM events

UNION

SELECT
    'High Engagement',
    COUNT(*)
FROM events
WHERE engagement_level = 'high_engagement'

UNION

SELECT
    'Shuffle Users',
    COUNT(*)
FROM events
WHERE shuffle = 1

UNION

SELECT
    'Long Sessions',
    COUNT(*)
FROM events
WHERE minutes_played > 10;

# CHURN ANALYSIS
# Highest Skip Users
SELECT
    CASE
        WHEN skip_flag = 1 THEN 'High Skip'
        ELSE 'Low Skip'
    END AS skip_behavior,

    ROUND(AVG(engagement_score), 2) AS avg_engagement

FROM events

GROUP BY skip_behavior;

# SEGMENTATIONS
# Listener Segments
SELECT
    CASE
        WHEN minutes_played < 3 THEN 'Casual Listener'
        WHEN minutes_played BETWEEN 3 AND 10 THEN 'Regular Listener'
        ELSE 'Binge Listener'
    END AS listener_segment,

    COUNT(*) AS total_users,

    ROUND(AVG(engagement_score), 2) AS avg_engagement

FROM events

GROUP BY listener_segment

ORDER BY avg_engagement DESC;