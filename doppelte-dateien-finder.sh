find . -type f -print0 | xargs -0 md5sum | sort | uniq -w32 -d --all-repeated=separate | cut -c35-  
