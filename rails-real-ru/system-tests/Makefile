setup:
	bin/setup
	bin/rails db:fixtures:load
	yarn

start:
	bin/dev

console:
	bin/rails console

test:
	yarn run build
	yarn run build:css
	NODE_ENV=test bin/rails test

.PHONY: test
