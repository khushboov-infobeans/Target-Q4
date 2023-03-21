# This is a basic VCL configuration file for varnish.  See the vcl(7)
# man page for details on VCL syntax and semantics.
# 
# Default backend definition.  Set this to point to your content
# server.
# 
backend default {
    .host = "127.0.0.1";
    .port = "8080";
    .connect_timeout = 500s;
    .first_byte_timeout = 500s;
    .between_bytes_timeout = 500s;
}
#backend admin {
#  .host = "127.0.0.1";
#  .port = "8080";
#  .connect_timeout = 1200s;
#  .first_byte_timeout = 1200s;
#  .between_bytes_timeout = 1200s;
#}

sub vcl_recv {
        if (( (req.http.host ~ "^(?i)docker.sdm.com") ) && req.http.X-Forwarded-Proto !~ "(?i)https") {
                set req.http.x-redir = "https://" + req.http.host + req.url;
                #return (synth(750, ""));
                error 750;
        }

        if (req.http.Accept-Encoding) {
                if (req.http.Accept-Encoding ~ "gzip") {
                        # If the browser supports it, we'll use gzip.
                        set req.http.Accept-Encoding = "gzip";
                }
                else if (req.http.Accept-Encoding ~ "deflate") {
                        # Next, try deflate if it is supported.
                        set req.http.Accept-Encoding = "deflate";
                }
                else {
                        # Unknown algorithm. Remove it and send unencoded.
                        unset req.http.Accept-Encoding;
                }
        }
}

sub vcl_error {
  if (obj.status == 750) {
    set obj.status = 301;
    set obj.http.Location = req.http.x-redir;
    return(deliver);
  }
}
