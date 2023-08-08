setup:
	bin/setup

start:
	bin/dev

console:
	bin/rails console

lint:
	bundle exec rubocop .

lint-fix:
	bundle exec rubocop -A .

test:
	yarn run build
	yarn run build:css
	NODE_ENV=test bin/rails test

.PHONY: test
