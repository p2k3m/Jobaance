# Jobaance Static Website

A colorful static landing page for **Jobaance** – a finance education and career training platform.

Deployment is **entirely manual**; this repository intentionally provides **no** automation such as deployment scripts or infrastructure templates.

## Manual Deployment (example: jobaance.myatscv.com)

Because no scripts or templates are included, set up the hosting stack yourself. One possible approach is:

1. Create an S3 bucket named `jobaance.myatscv.com` and enable static website hosting with public read access. Upload the site files from this repository, for example:

   ```bash
   aws s3 sync . s3://jobaance.myatscv.com
   ```

2. In AWS Certificate Manager (us-east-1), request a public certificate for `jobaance.myatscv.com`.

3. Create a CloudFront distribution:
   - Origin: the S3 website endpoint for `jobaance.myatscv.com`.
   - Attach the ACM certificate.
   - Set the default root object to `index.html`.

4. In Route 53, add an alias `A` record for `jobaance.myatscv.com` pointing to the CloudFront distribution.

### Troubleshooting

- Clear browser caches if updates do not appear.
- DNS changes may take time; verify propagation with tools like `dig` or `nslookup`.

## Project Structure

```
├── index.html       # Landing page markup
├── style.css        # Styling
└── script.js        # Small JS for nav + animations
```

## License

[MIT](LICENSE)
