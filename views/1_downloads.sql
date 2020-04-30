CREATE VIEW downloads AS SELECT
  repos.name,
  releases.tag_name,
  SUM(assets.download_count) AS downloads,
  assets.created_at
FROM
  assets
INNER JOIN
  releases ON assets.release=releases.id
INNER JOIN
  repos ON releases.repo=repos.id
GROUP BY
  release
ORDER BY
  assets.created_at DESC
