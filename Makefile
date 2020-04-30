DATABASE=kubernetes-tools.db

build: data views

sort: tools
	sort $^ -o $^

data: tools
	@while read repo; do \
		pipenv run github-to-sqlite releases ${DATABASE} $${repo} ; \
	done < $^

views: views/*.sql
	@for view in $^ ; do \
		sqlite3 ${DATABASE} < $${view} ; \
    done

serve:
	@pipenv run datasette ${DATABASE} -m metadata.json

.PHONY: build sort data views serve
