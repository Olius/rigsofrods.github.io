server: clean translate
	bundle exec middleman server --verbose

deploy: clean translate
	rm -rf build/*
	bundle exec middleman build
	bundle exec middleman deploy

clean:
	rm -rf build/* source/localizable/blog/2* source/localizable/docs source/localizable/download
	find pregen/po | grep ".po~" | xargs rm -f

translate:
	cp -rf pregen/source/* source/localizable
	po4a-bulk-translate pregen/source asciidoc adoc pregen/po source/localizable "ru"

gettextize:
	rm -rf pregen/pot/*
	po4a-bulk-gettextize pregen/source asciidoc adoc pregen/pot

updatepo:
	po4a-bulk-updatepo pregen/source asciidoc adoc pregen/po "ru"
