# Makefile for openscad project

MIRROR_FILES=n7-adapter-plate.stl n7-mirror-holder.stl
mirror: $(MIRROR_FILES)

# Generic stl file builder
%.stl : %.scad
	openscad -o $@ $<

clean:
	rm -f $(MIRROR_FILES)
