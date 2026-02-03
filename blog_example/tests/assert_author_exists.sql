-- Test to ensure all blog posts have valid authors
select bp.id, bp.author_name
from {{ ref('blog_posts_enhanced') }} bp
where bp.author_name is null
