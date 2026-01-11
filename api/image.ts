import type { VercelRequest, VercelResponse } from 'vercel';

export const config = {
  runtime: 'nodejs',
};

export default async function handler(
  req: VercelRequest,
  res: VercelResponse
) {
  const rawUrl = req.query.url;

  if (!rawUrl || typeof rawUrl !== 'string') {
    res.status(400).send('Missing url');
    return;
  }


  const targetUrl = decodeURIComponent(rawUrl);

  try {
    const response = await fetch(targetUrl);

    if (!response.ok) {
      res.status(response.status).send('Failed to fetch image');
      return;
    }

    const contentType = response.headers.get('content-type');
    if (contentType) {
      res.setHeader('Content-Type', contentType);
    }

    const buffer = Buffer.from(await response.arrayBuffer());

    res.setHeader('Cache-Control', 'public, max-age=86400');

    res.status(200).send(buffer);
  } catch (error) {
    res.status(500).send('Proxy error');
  }
}
