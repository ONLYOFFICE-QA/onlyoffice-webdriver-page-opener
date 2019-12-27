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

### Saving screenshot to S3

This is optional, if not specified - screenshot saved locally

`S3_KEY` - S3 key
`S3_PRIVATE_KEY` - S3 private key 
