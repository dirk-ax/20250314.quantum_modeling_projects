# Axiomatic_AI Education Initiative Website

This is a static website for the Axiomatic_AI Education Initiative on Truthful and Verifiable AI. The site showcases the program call for participation, funding details, and contribution opportunities for research groups.

## Features

- Responsive design that works on mobile and desktop
- Interactive tabs for exploring program scope
- Researcher profiles highlighting potential contributions
- Application information and form
- Detailed technical requirements section

## Structure

- `index.html` - Main HTML file
- `css/styles.css` - Stylesheet
- `js/main.js` - JavaScript for interactivity
- `images/` - Directory for images (not included)

## GitHub Pages

This website is designed to be hosted on GitHub Pages. After pushing to the repository, enable GitHub Pages in the repository settings to make the site publicly accessible.

## Local Testing

To test locally, simply open `index.html` in a web browser or use a local server.

Example using Python's built-in HTTP server:

```bash
# From inside a Docker container (as per Axiomatic_AI requirements)
cd /path/to/website
python -m http.server 8080
```

Then visit `http://localhost:8080` in your browser.

## Technical Specifications

- No server-side code (static site only)
- Minimal JavaScript for basic interactivity
- Fully responsive design
- No external dependencies other than Font Awesome for icons

## Deployment Notes

When deploying to production:

1. Replace placeholder images with actual Axiomatic_AI branding
2. Connect the form to a proper backend service
3. Update any contact information or deadlines as needed
