-- Test to ensure view_count is never negative
select *
from {{ ref('blog_posts_enhanced') }}
where view_count < 0
