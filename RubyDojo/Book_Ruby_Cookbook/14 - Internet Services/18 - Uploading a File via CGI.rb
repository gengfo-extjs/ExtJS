#!/usr/bin/ruby
# upload.rb

# Save uploaded files to this directory
UPLOAD_DIR = "/usr/local/www/uploads"

require 'cgi'
require 'stringio'
#---
def display_form(cgi)
 action = ENV['SCRIPT_NAME']
 return <<EOF
<FORM ACTION="#{action}" METHOD="post" ENCTYPE="multipart/form-data">
 File to Upload: <INPUT TYPE="file" NAME="file_name"><br>
 Your email address: <INPUT TYPE="text" NAME="email_address"
                      VALUE="guest@example.com"><br>
 <INPUT TYPE="submit" NAME="Submit" VALUE="Submit Form">
 </FORM>
EOF
end
#---
def process_form(cgi)
  email = cgi.params['email_address'][0]
  fileObj = cgi.params['file_name'][0]

  str = '<h1>Upload report</h1>' +
    "<p>Thanks for your upload, #{email.read}</p>"
  if fileObj
    path = fileObj.original_filename
    str += "Original Filename : #{path}" + cgi.br
    dest = File.join(UPLOAD_DIR, sanitize_filename(path))
    
    str += "Destination : #{dest} <br>"
    File.open(dest.untaint, 'wb') { |f| f << fileObj.read }
    
    # Delete the temporary file if one was created
    local_temp_file = fileObj.local_path()
    File.unlink(local_temp_file) if local_temp_file
  end
  return str
end
#---
def sanitize_filename(path)
  if RUBY_PLATFORM =~ %r{unix|linux|solaris|freebsd}
    # Not required for unix platforms since all characters
    # are allowed (except for /, which is stripped out below).
  elsif RUBY_PLATFORM =~ %r{win32}
    # Replace illegal characters for NTFS with _
    path.gsub!(/[\x00-\x1f\/|?*]/,'_')
  else
    # Assume a very restrictive OS such as MSDOS
     path.gsub!(/[\/|\?*+\]\[ \x00-\x1fa-z]/,'_')
  end

  # For files uploaded by Windows users, strip off the beginning path.
  return path.gsub(/^.*[\\\/]/, '')
end
#---
cgi = CGI.new('html3')
if cgi.request_method !~ %r{POST}
  buf = display_form(cgi)
else
  buf = process_form(cgi)
end

cgi.out() do
  cgi.html() do
    cgi.head{ cgi.title{'Upload Form'} } + cgi.body() { buf }
  end
end

exit 0
#---
# Limit uploads to BMP files.
raise 'Wrong type!' unless fileObj.content_type =~ %r{image/bmp}
#---
