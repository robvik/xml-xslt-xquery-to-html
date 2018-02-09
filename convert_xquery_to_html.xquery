xquery version "3.0" encoding "UTF-8";

declare namespace saxon="http://saxon.sf.net/";
declare option saxon:output "method=html";
declare option saxon:output "doctype-public=-//W3C//DTD HTML 4.01 Transitional//EN";

(: Author: Robin Viktorsson (rovi1601) :)
(: Date: 2017-11-02 :)
(: Filename: convert_xquery_to_html.xquery :)

declare function local:getChannelName($channel as xs:string?)
as xs:string?
{
	switch ($channel)
	   case "svt1.svt.se" return "SVT1"
	   case "svt2.svt.se" return "SVT2"
	   case "tv3.se" return "TV3"
	   case "tv4.se" return "TV4"
	   case "kanal5.se" return "Kanal5"
	   case "tv6.se" return "TV6"
	   case "sjuan.se" return "Sjuan"
	   case "tv8.se" return "TV8"
	   default return "Channelname doesnt exist."
};

declare function local:getTypeName($type as xs:string?)
as xs:string?
{
	switch ($type)
		   case "movie" return "<span class='movie'>Film</span>"
		   case "series" return "<span class='series'>Serie</span>"
		   case "tvshow" return "<span class='tvshow'>Tv show</span>"
		   case "sports" return "<span class='sports'>Sport</span>"
		   default return "Type doesnt exist."
};

<html>
    <head>
      <title>XML, XSLT and XQuery Project - Robin Viktorsson</title>
      <link rel="stylesheet" href="css/style.css"/>
      <link rel="stylesheet" href="css/jquery-ui.min.css"/>
      <script src="js/jquery-3.2.1.min.js"></script>
      <script src="js/jquery-ui.min.js"></script>
      <script type="text/javascript" src="js/custom.js"></script>
    </head>
    <body>
    {

      <div class="main_container">
      <div class="top_container">
        <div id="logo"></div>
      </div>

      <div class="middle_container">
      {
      let $doc := doc("xml_docs/allChannels.xml")
      for $tv in $doc/allchannels/tv
      return
      <div class="channel_container">
				<div class="channel_header">
					<div class="channel_logo">
						<img src="{concat('images/', data($tv/@logo))}"/>
					</div>
					<div class="channel_name">
						{local:getChannelName(data($tv/@channel))}
					</div>
				</div>
				{for $programme in $tv/programme
				return
				<div class="channel_programmes" data-id="{data($programme/id)}">
					<span class="programme_time" data-stoptime="{data($programme/stop)}">
						{data($programme/start)}
					</span>
					<span class="programme_title">
						{data($programme/title)}
					</span>	
					{
					let $x := $programme/type
                    return            
                    if ($x = 'movie') then
                        (<span class="movie">Film</span>)
                    else if($x = 'series') then
                        (<span class="series">Serie</span>)
                    else if($x = 'tvshow') then
                        (<span class="tvshow">Tv show</span>)
                    else if($x = 'sports') then
                        (<span class="sports">Sport</span>)
                    else()
                    }
				</div>
				}
			</div>
      }
      </div>

      <div class="footer">
        <div class="footer_container">
          <p class="footer_title">Om oss</p>
          <p class="footer_content">
              tv.nu är Sveriges största tv-guide med över 2,3 miljoner unika besökare varje vecka.
            <br/>
            <br/>
            <a href="#">Kontakt</a>
            <br/>
            <a href="#">Tyck till</a>
            <br/>
            <a href="#">Mer om oss</a>
            <br/>
            <a href="#">Anmäl störande/felaktig annons</a>
            <br/>
          </p>
        </div>
        <div class="footer_container">
          <p class="footer_title">Samarbete</p>
          <p class="footer_content">
          tv.nu används i soffan framför tv:n och trafiken ökar upp till 800% under tv-reklampauserna. Med annonsering hos oss får ni räckvidd i en brusfri och ren annonsmiljö.
            <br/>
            <br/>
            <a href="#">Annonsera här</a>
            <br/>
            <a href="#">Jobb</a>
            <br/>
          </p>
        </div>
        <div class="footer_container">
          <p class="footer_title">Övrigt</p>
          <p class="footer_content">
            <a href="#">Kanalbibliotek</a>
            <br/>
            <a href="#">Skriv ut tablån</a>
            <br/>
            <a href="#">Sitemap</a>
            <br/>
          </p>
        </div>
        <div class="footer_container">
          <p class="footer_title">Följ oss</p>
          <p class="footer_content">
            <img src="images/facebook.jpg" style="margin-right: 10px;"/>
            <img src="images/twitter.jpg" style="margin-right: 10px;"/>
            <img src="images/instagram.jpg"/>
            <br/>
            <a href="#">Tv.nu blogg</a>
            <br/>
            <br/>
          Tv.nu:s nyhetsbrev:
            <br/>
            <input id="nyhetsbrev" type="search" placeholder="Fyll i din e-post"/>
            <br/>
            <input type="submit" value="Prenumerera" style="margin-top: 5px;"/>
          </p>
        </div>
      </div>
      </div>
    }</body>
</html>
