LINGUAS="ru"

server: clean translate
	bundle exec middleman server --verbose

build: clean translate
	rm -rf build/*
	bundle exec middleman build

clean: clean-po
	rm -rf build/* source/blog/2* source/localizable/docs source/localizable/download

clean-po:
	find blog/po content/po | grep ".po~" | xargs rm -f

translate:
	po4a-bulk-translate content/source asciidoc adoc content/po source/localizable $(LINGUAS)
	po4a-bulk-translate blog/source asciidoc adoc blog/po source $(LINGUAS)

	./copy_en.sh

gettextize:
	rm -rf content/pot/*
	rm -rf blog/pot/*
	po4a-bulk-gettextize content/source asciidoc adoc content/pot
	po4a-bulk-gettextize blog/source asciidoc adoc blog/pot

updatepo:
	po4a-bulk-updatepo content/source asciidoc adoc content/po $(LINGUAS)
	po4a-bulk-updatepo blog/source asciidoc adoc blog/po $(LINGUAS)
	make clean-po
