# onlyoffice-webdriver-page-opener

Tool for open browser window with specific page

## How to generate load

```bash
for run in {1..10}
do
  docker run -itd shockwavenn/onlyoffice-webdriver-page-opener
  sleep 20
done
```

## Parameters

Send as environment variables

`URL` - address of server to generate load  
`SCREENSHOT_TIMEOUT` - timeout between making screenshot.
Default to `60` seconds

### Saving screenshot to S3

This is optional, if not specified - screenshot saved locally

`S3_KEY` - S3 key  
`S3_PRIVATE_KEY` - S3 private key

### Rake tasks

For correct work of rake task you should specify 
some ENV variables (for example in `~/.bashrc` file)

`WEBDRIVER_PAGE_OPENER_SSH_KEY_ID` - id of SSH key in DigitalOcean API
`WEBDRIVER_PAGE_OPENER_S3_KEY` - S3 Key
`WEBDRIVER_PAGE_OPENER_S3_PRIVATE_KEY=` - S3 private key
`WEBDRIVER_PAGE_OPENER_DS_URL` - url of DocumentServer to open
