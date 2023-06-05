#1.User Engagement: To measure the activeness of a user. Measuring if theuser finds quality in a product/service.
#We Calculate the weekly user engagement

select extract(week from occurred_at) as numbers, count(distinct user_id) as active_users
from operational_analytics.table_events
where event_type = "engagement"
group by 1


# 2.User Growth: Amount of users growing over time for a product.
# Calculate the user growth for product

select months, users, round(((users/lag(users,1) over(order by months) - 1)*100),2) as growth_percenatge

from
( 
select extract(month from created_at) months, count(activated_at) as users 
from operational_analytics.table_users
where activated_at not in ("")
group by 1
order by 1
)b;

# 3. Weekly Retention: Users getting retained weekly after signing-up for a product.
# Calculate the weekly retention of users-sign up cohort
SELECT first as "week Numbers",
SUM( CASE WHEN week_number=0 then 1 else 0 END) AS "WEEK 0",
SUM( CASE WHEN week_number=1 then 1 else 0 END) AS "WEEK 1",
SUM( CASE WHEN week_number=2 then 1 else 0 END) AS "WEEK 2",
SUM( CASE WHEN week_number=3 then 1 else 0 END) AS "WEEK 3 ",
SUM( CASE WHEN week_number= 4 then 1 else 0 END) AS "WEEK 4 ",
SUM( CASE WHEN week_number= 5 then 1 else 0 END) AS "WEEK 5 ",
SUM( CASE WHEN week_number=6  then 1 else 0 END) AS "WEEK 6",
SUM( CASE WHEN week_number= 7 then 1 else 0 END) AS "WEEK 7 ",
SUM( CASE WHEN week_number= 8 then 1 else 0 END) AS "WEEK 8",
SUM( CASE WHEN week_number= 9 then 1 else 0 END) AS "WEEK 9 ",
SUM( CASE WHEN week_number= 10 then 1 else 0 END) AS "WEEK 10 ",
SUM( CASE WHEN week_number= 11 then 1 else 0 END) AS "WEEK 11",
SUM( CASE WHEN week_number= 12 then 1 else 0 END) AS "WEEK 12",
SUM( CASE WHEN week_number= 13 then 1 else 0 END) AS "WEEK 13",
SUM( CASE WHEN week_number= 14 then 1 else 0 END) AS "WEEK 14",
SUM( CASE WHEN week_number= 15 then 1 else 0 END) AS "WEEK 15",
SUM( CASE WHEN week_number= 16 then 1 else 0 END) AS "WEEK 16",
SUM( CASE WHEN week_number=17 then 1 else 0 END) AS "WEEK 17",
SUM( CASE WHEN week_number=18 then 1 else 0 END) AS "WEEK 18",
FROM
(
SELECT m.user_id, m.login_week, n.first, m.login_week First AS week_number
FROM 
(SELECT  user_id, EXTRACT(WEEK FROM occurred_at) as login_week FROM operational_analytics.table_events
GROUP BY 1,2)m,
(SELECT  user_id,  MIN(EXTRACT(WEEK FROM ocurred_at)) as first FROM operational_analytics.table_events 
GROUP BY 1) n 
WHERE m.user_id = n.user_id
)b 
GROUP BY first 
ORDER BY first;







# 4.Weekly Engagement: To measure the activeness of a user. Measuring if the user finds quality in a product/service weekly.
# Calculate the weekly engagement per device?

select extract(week from occurred_at) as no_of_weeks,
count(distinct case when device in('acer aspire desktop') then user_id else null end) as'acer aspire desktop ',
count(distinct case when device in('amazon fire phone') then user_id else null end) as' amazon fire phone',
count(distinct case when device in('asus chromebook') then user_id else null end) as'asus chromebook ',
count(distinct case when device in('dell inspiron notebook') then user_id else null end) as'dell inspiron notebook ',
count(distinct case when device in('hp pavilion desktop') then user_id else null end) as'hp pavilion desktop ',
count(distinct case when device in('htc one') then user_id else null end) as'htc one ',
count(distinct case when device in('Ipad air') then user_id else null end) as'ipad air ',
count(distinct case when device in('ipad mini') then user_id else null end) as'ipad mini ',
count(distinct case when device in('iphone 4s') then user_id else null end) as'iphone 4s ',
count(distinct case when device in('iphone 5') then user_id else null end) as'iphone 5 ',
count(distinct case when device in('iphone 5s') then user_id else null end) as'iphone 5s ',
count(distinct case when device in('kindle fire') then user_id else null end) as'kindle fire ',
count(distinct case when device in('lenovo thinkpad') then user_id else null end) as'lenovo thinkpad ',
count(distinct case when device in('macbook air') then user_id else null end) as'macbook air ',
count(distinct case when device in('mac mini') then user_id else null end) as'mac mini ',
count(distinct case when device in('macbook pro') then user_id else null end) as'macbook pro ',
count(distinct case when device in('nexus 10') then user_id else null end) as'nexus 10 ',
count(distinct case when device in('nexus 5') then user_id else null end) as'nexus 5 ',
count(distinct case when device in('nokia lumia 635') then user_id else null end) as'nokia lumia 635 ',
count(distinct case when device in('samsung galaxy note') then user_id else null end) as'samsung galaxy note ',
count(distinct case when device in('samsung galaxy s4') then user_id else null end) as'samsung galaxy s4 ',
count(distinct case when device in('windows surface') then user_id else null end) as'windows surface '
from operational_analytics.table_events
where  event_type='engagement'
group by 1
order by 1;

#5. Email Engagement: Users engaging with the email service.
# Calculate the email engagement metrics?
select weeks ,
round((weekly_digest/total*100),2) as weekly_digest,
round ((email_opens/total*100),2) as rate_of_email_open,
round((email_clickthroughs/total*100),2) as rate_of_email_clickthroughs,
round ((reengagement_emails/total*100),2) as rate_of_reengagement_emails

from
(
select extract(week from occurred_at) as weeks,
count(case when action ='sent_weekly_digest' then user_id else null end) as weekly_digest,
count(case when action ='email_open' then user_id else null end) as email_opens,

count(case when action ='email_clickthrough' then user_id else null end) email_clickthroughs,
count(case when action ='sent_reengagement_email' then user_id else null end) as reengagement_emails,

count(user_id) as total
from operational_analytics.email_events
group by 1 
)b

group by 1
order by 1 ;


