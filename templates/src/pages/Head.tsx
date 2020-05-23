import React from 'react';
import { default as HeadTag } from 'next/head';

const Head = () => (
  <HeadTag>
    <title>My title</title>
    <meta name="viewport" content="initial-scale=1.0, width=device-width" />

    <meta name="robots" content="index,follow" />
    <meta name="title" content="My title" />
    <meta name="description" content="My description" />
    <meta name="keywords" content="meyword" />

    {/* Opengraph */}
    <meta property="og:url" content={process.env.site} />
    <meta property="og:type" content="website" />
    <meta property="og:site_name" content="My title" />
    <meta property="og:locale" content="en_US" />
    <meta property="og:title" content="My title" />
    <meta property="og:description" content="My description" />
    <meta
      property="og:image"
      content={`${process.env.assetPrefix}/TwitterCard.jpg`}
    />
    <meta property="og:image:alt" content="" />

    {/* Twitter */}
    <meta name="twitter:description" content="My description" />
    <meta name="twitter:site" content="@andrewray" />
    <meta name="twitter:creator" content="@andrewray" />
    <meta name="twitter:card" content="summary_large_image" />
    <meta
      name="twitter:image"
      content={`${process.env.assetPrefix}/TwitterCard.jpg`}
    />
    <meta name="twitter:image:alt" content="" />

    <script
      async
      src="https://www.googletagmanager.com/gtag/js?id=UA-12379271-4"
    ></script>
    <script
      dangerouslySetInnerHTML={{
        __html: `
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());

gtag('config', 'UA-12379271-4');
`,
      }}
    ></script>
  </HeadTag>
);

export default Head;
