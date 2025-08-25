def hex2dec($h):
  "0123456789abcdef" as $hex |
  ($hex | index($h[0:1] | ascii_downcase)) * 16 +
  ($hex | index($h[1:2] | ascii_downcase));

def dec2hex($n):
  "0123456789abcdef" as $hex |
  ($n / 16 | floor) as $hi |
  ($n % 16) as $lo |
  ($hex[$hi:$hi+1] + $hex[$lo:$lo+1]);

def blend(rgba; bg):
  if (rgba|length)==9 then
    {
      r: hex2dec(rgba[1:3]),
      g: hex2dec(rgba[3:5]),
      b: hex2dec(rgba[5:7]),
      a: hex2dec(rgba[7:9])/255
    } as $f |
    {
      r: hex2dec(bg[1:3]),
      g: hex2dec(bg[3:5]),
      b: hex2dec(bg[5:7])
    } as $b |
    "#" +
    dec2hex( ($f.r*$f.a + $b.r*(1-$f.a)) | floor ) +
    dec2hex( ($f.g*$f.a + $b.g*(1-$f.a)) | floor ) +
    dec2hex( ($f.b*$f.a + $b.b*(1-$f.a)) | floor )
  else
    rgba
  end;
