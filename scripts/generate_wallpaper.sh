original_wallpaper=$1
full_filename=$(basename -- "$original_wallpaper")
extension="${full_filename##*.}"
filename="${full_filename%.*}"

echo "Processing $full_filename"

mkdir -p /tmp/i3_wallpaper
res=$(xrandr --query | grep "\*" | awk '{print $1}')
tmp_imgs=()
for item in $res
do
  echo "Resizing to resolution $item"
  convert $original_wallpaper -resize $item\> /tmp/i3_wallpaper/$item.$extension
  tmp_imgs+=(/tmp/i3_wallpaper/$item.$extension)
done

output_wallpaper="${filename}_merged.${extension}"
echo "Merging images to $output_wallpaper"
IFS=" "
convert ${tmp_imgs[*]} +append $output_wallpaper
