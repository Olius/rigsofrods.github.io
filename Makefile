LINGUAS="ru"

server: clean translate
	bundle exec middleman server --verbose

deploy: clean translate
	rm -rf build/*
	- bundle exec middleman build
	bundle exec middleman deploy

clean: clean-po
	rm -rf build/* source/localizable/blog/2* source/localizable/docs source/localizable/download

clean-po:
	find content/po | grep ".po~" | xargs rm -f

translate:
	cp -rf content/source/* source/localizable
	po4a-bulk-translate content/source asciidoc adoc content/po source/localizable $(LINGUAS)

gettextize:
	rm -rf content/pot/*
	po4a-bulk-gettextize content/source asciidoc adoc content/pot

updatepo:
	po4a-bulk-updatepo content/source asciidoc adoc content/po $(LINGUAS)
	make clean-po
