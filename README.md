# playme
Backend for guitar song suggestion app


How to query a songsterr song:

Best Match URL

If you have artist name and song title and want to construct url to the tab page on Songsterr, you can use the following format:

http://www.songsterr.com/a/wa/bestMatchForQueryString?s={song title}&a={artist name},
e.g.:

http://www.songsterr.com/a/wa/bestMatchForQueryString?s=Wonderwall&a=Oasis
if you want to link to tab with bass track selected by default, add "inst=bass" url parameter:

http://www.songsterr.com/a/wa/bestMatchForQueryString?s=Come+Together&a=Beatles&track=bass