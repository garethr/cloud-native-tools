DATABASE=cloud-native-tools.db

build: data views

sort: tools
	sort $^ -o $^

data: tools
	@while read repo; do \
		echo "Importing $${repo}" ; \
		pipenv run github-to-sqlite releases ${DATABASE} $${repo} ; \
		pipenv run github-to-sqlite contributors ${DATABASE} $${repo} ; \
	done < $^

views: views/*.sql
	@for view in $^ ; do \
		sqlite3 ${DATABASE} < $${view} ; \
    done

deploy:
	@pipenv run datasette publish heroku ${DATABASE} -n cloud-native-tools -m metadata.json

serve:
	@pipenv run datasette ${DATABASE} -m metadata.json

.PHONY: build sort data views deploy serve
