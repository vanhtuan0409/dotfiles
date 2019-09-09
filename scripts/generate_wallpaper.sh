convert $DOTFILES/resources/wallpaper.jpg -resize 1600x900\> wallpaper_1600x900.jpg
convert $DOTFILES/resources/wallpaper.jpg -resize 1920x1080\> wallpaper_1920x1080.jpg
convert $DOTFILES/resources/wallpaper_1600x900.jpg $DOTFILES/resources/wallpaper_1920x1080.jpg $DOTFILES/resources/wallpaper_1920x1080.jpg +append $DOTFILES/resources/wallpaper_tripple.jpg
