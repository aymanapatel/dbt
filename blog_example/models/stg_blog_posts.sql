{{ config(materialized='table') }}

select
    id,
    title,
    slug,
    author_id,
    content,
    is_published,
    view_count,
    current_timestamp as created_at,
    current_timestamp as updated_at
from {{ ref('blog_posts') }}
where is_published = true
