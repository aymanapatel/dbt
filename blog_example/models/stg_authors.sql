{{ config(materialized='table') }}

select
    id,
    name,
    email,
    bio,
    current_timestamp as created_at
from {{ ref('authors') }}
