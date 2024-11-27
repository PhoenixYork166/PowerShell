function create-basichtml {

    param($htmlControls=$nll, $javascript = $null)
    $html = @"
    <!DOCTYPE html PUBLIC "-//w3c//DTD_XHTML_1.0 Strict //EN"`
    "http://www.google.com"
    <html xmlns="https://www.google.com.hk/xhtmll">
    <head>
    <style>
    BODY(background-color:lightgray;margin:10px 10px 0 10px;font-family:vendana,arial,sans-serif;font-size:10px}

    TABLE{border-width: 1px;border-style: solid;border-color: grey;border-collapse: collapse;width:100%;margin: 0 0 0 0;font-size:10px}
    TH{border-width: 1px;padding: 10px;border-style: solid;border-color: black;background-color:lightblue}
    TR{vertical-aligh:top;}
    TD{border-width: 1px;padding: 10px;border-style: solid;border-color: black;background-color:white; vertical-align:top;}a{font-weight:bold;}

    table.simplex{border-width: 0px;padding: 0px: border-style: none;border-color: white;border-collapse: collapse;`
    width:100%;margin: 0 0 0 0;font-size: 10px}
    td.simple{border-width: 0px;padding: 0px;border-style: none;border-color: white;background-color: white; vertical-align:top;}

    </style>
    <script type="text/javascript">
    <!--
        $javascript

        //->
        </script>

        </head>
        <body>
        $htmlcontrols
        </body>
        </html>

"@
        return $html
}
