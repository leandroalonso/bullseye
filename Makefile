setup:
ifeq ($(shell gem list \^bundler\$$ -i), false)
	gem install bundler
endif
	bundle install

test:
	bundle exec fastlane test

ui_test:
	bundle exec fastlane ui_test

release:
	bundle exec fastlane release
