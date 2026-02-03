-- Test to ensure published posts have content
select id, title
from {{ ref('blog_posts_enhanced') }}
where is_published = true and (content is null or length(trim(content)) = 0)
