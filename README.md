# This is File Server of TCP Server #

Pure ruby implement TCP server to show local server file struct, it's can move the directory and show file.

## Usage ##

In clone project `rebuild-server`

```
ruby tcp_server.rb
```

This will open tcp server to handle http request and http header, Many junior ruby programmer don't know rack what to do, it's will to know to handle easy, and help other people who want to know detail.


In lib file struct

```
.
├── body.rb # => http body to render html 
├── env.rb # => will setting env to save request handle info
├── file.rb # => to read directory 
├── logger.rb # => like rack to output request info in console
├── request.rb # => handle request and save to env 
├── response.rb # => handle response
└── server.rb # => create tcp server entity
```

