# Change input and output details

output_path="test" # Output Path (Same will be pushed in main also)

input_url="https://stream.sbpmaza.workers.dev/0:/Sunaguri.mp4" # Input direct file url

input_extension="mp4" # Extension of file url

# Change ffmpeg configurations according to yur need (If you don't know, don't touch)

wget --quiet -O video.$input_extension $input_url

mkdir $output_path

ffmpeg -hide_banner -y -i video.$input_extension \

  -vf scale=w=640:h=360:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time  -hls_playlist_type vod  -b:v 800k -maxrate 856k -bufsize 1200k -b:a 96k -hls_segment_filename  $output_path/360p.m3u8 \

  -vf scale=w=1280:h=720:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time  -hls_playlist_type vod -b:v 1400k -maxrate 1498k -bufsize 2100k -b:a 96k -hls_segment_filename $output_path/720p.m3u8

rm video.$input_extension

cd $output_path

echo '#EXTM3U

#EXT-X-VERSION:3

#EXT-X-STREAM-INF:BANDWIDTH=800000,RESOLUTION=640x360

360p.m3u8

#EXT-X-STREAM-INF:BANDWIDTH=1400000,RESOLUTION=1280x720

720p.m3u8' > master.m3u8
