
# Laura's convenience command because Reasons
# docs: dev

.PHONY: docs
docs:
	bundle exec jekyll serve --force_polling --trace --incremental -H 0.0.0.0 -V

# .PHONY: dev
# dev: node_modules vendor/bundle
# 	@$(BIN)/concurrently --raw --kill-others -n webpack,jekyll \
# 		"$(BIN)/webpack --mode=development --watch" \
# 		"bundle exec jekyll clean && bundle exec jekyll serve --force_polling --trace --incremental -H 0.0.0.0 -V"

.PHONY: intialize-work-dir
intialize-work-dir:
	@mkdir -p _site
	@chmod -R 777 _site/
	@mkdir vendor
	@chmod -R 777 vendor/
	@bundle install --path=vendor

.PHONY: build
build: node_modules vendor/bundle
	@$(BIN)/concurrently --raw --kill-others -n webpack,jekyll \
		"$(BIN)/webpack --mode=development --watch" \
		"bundle exec jekyll clean && bundle exec jekyll build -V"

# .PHONY: build
# build: node_modules vendor/bundle
# 	@echo "Jekyll env: ${JEKYLL_ENV}"
# 	@chown -R jekyll /workdir
# 	@chmod -R 777 /workdir
# 	@echo "env: ${JEKYLL_ENV}"
# 	@$(BIN)/webpack --mode=production
# 	@JEKYLL_ENV=${JEKYLL_ENV} bundle exec jekyll build --trace
# 	@if [ '${BUILDKITE_BRANCH}' == 'staging' ]; then echo "updating sitemap.xml..." && sed -i -r 's/segment.com/segment.build/g' ./_site/sitemap.xml; fi;

#
# .PHONY: sidenav
# sidenav: vendor/bundle
# 	@node scripts/nav.js
#
# # check internal links
# .PHONY: linkcheck-internal
# linkcheck-internal:
# 	@node scripts/checklinks-internal.js
#
# # check external links
# .PHONY: linkcheck-external
# linkcheck-external:
# 	@node scripts/checklinks-external.js


.PHONY: env
env:
	@sh scripts/env.sh

.PHONY: clean
clean:
	@rm -Rf _site
	@rm -Rf .sass-cache
	@rm -Rf .jekyll-cache
	@rm -Rf src/.jekyll-metadata
	@rm -f assets/docs.bundle.js

.PHONY: clean-deps
clean-deps:
	@rm -Rf vendor
	@rm -Rf node_modules

.PHONY: seed
seed:
	@cp templates/destinations.example.yml src/_data/catalog/destinations.yml
	@cp templates/sources.example.yml src/_data/catalog/sources.yml

.PHONY: node_modules
node_modules: package.json yarn.lock
	yarn --frozen-lockfile

.PHONY: vendor/bundle
vendor/bundle:
	@export BUNDLE_PATH="vendor/bundle"
	@mkdir -p vendor && mkdir -p vendor/bundle
	@chmod -R 777 vendor/ Gemfile.lock
	@bundle config set --local path 'vendor/bundle'
	@bundle install

.PHONY: update
update:
	@node scripts/update.js

.PHONY: add-id
add-id:
	@node scripts/add_id.js

.PHONY: lint
lint: node_modules
	@echo "Checking yml files..."
	@npx yamllint src/_data/**/*.yml
	# @echo "Checking markdown files..."
	# @npx remark ./src --use preset-lint-markdown-style-guide

.PHONY: test
test: lint

.PHONY: check-spelling
check-spelling:
	@echo 'Check spelling in markdown files..."
	@npx mdspell 'src/**/*.md' -r --en-us -h
