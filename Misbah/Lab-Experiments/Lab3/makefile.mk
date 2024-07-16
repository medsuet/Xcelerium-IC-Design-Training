FILES:= HelloWorld.sh name.sh number.sh sum.sh multiples.sh guessgame.sh factorial.sh fruits.sh capitals.sh filereader.sh logreader.sh backup.sh

all: $(FILES)

$(FILES):
	@if [ "$@" =  "number.sh" ] || [ "$@" = "multiples.sh"  ]; then \
		chmod +x "$@" && ./"$@" 3; \
	else \
		chmod +x $@ && ./$@; \
	fi

.PHONY: all $(FILES)

