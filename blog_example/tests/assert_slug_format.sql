-- Test to ensure slugs follow proper format (lowercase, hyphens only)
select *
from {{ ref('blog_posts_enhanced') }}
where slug ~ '[A-Z]' or slug ~ '[^a-z0-9\-]'
