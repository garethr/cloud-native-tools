CREATE VIEW contributions AS SELECT
  users.login AS username,
  SUM(contributions) AS commits,
  COUNT(repos.name) AS num_projects,
  GROUP_CONCAT(repos.name) AS projects
FROM
  contributors
INNER JOIN
  users ON contributors.user_id=users.id
INNER JOIN
  repos on contributors.repo_id=repos.id
GROUP BY
  user_id
ORDER BY
  contributions DESC
