main:
	mkdir -p dist/
	ca65 src/game.asm -o dist/game.o
	ld65 dist/game.o -C game.cfg -o game.nes

run: game.nes
	fceux game.nes

clean: game.nes
	rm -fr game.nes dist/
