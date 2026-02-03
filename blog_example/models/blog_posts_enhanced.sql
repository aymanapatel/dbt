{{ config(materialized='table') }}

select
    bp.id,
    bp.title,
    bp.slug,
    bp.content,
    a.name as author_name,
    a.email as author_email,
    bp.is_published,
    bp.view_count,
    bp.created_at,
    bp.updated_at
from {{ ref('stg_blog_posts') }} bp
left join {{ ref('stg_authors') }} a on bp.author_id = a.id
