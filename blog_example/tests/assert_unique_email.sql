-- Test to ensure author emails are unique
select email, count(*) as email_count
from {{ ref('stg_authors') }}
group by email
having count(*) > 1
