import type { VercelRequest, VercelResponse } from '@vercel/node';
import fetch from 'node-fetch';

export default async function handler(req: VercelRequest, res: VercelResponse) {
  try {
    const url = req.query.url as string;

    if (!url) {
      res.status(400).send('Missing url query parameter');
      return;
    }

    // Server 端抓圖片
    const response = await fetch(url);
    if (!response.ok) {
      res.status(502).send('Failed to fetch image');
      return;
    }

    const contentType = response.headers.get('content-type') || 'image/jpeg';
    const buffer = await response.arrayBuffer();


    res.setHeader('Content-Type', contentType);
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Cache-Control', 'public, max-age=86400');
    res.send(Buffer.from(buffer));
  } catch (err) {
    console.error(err);
    res.status(500).send('Server error');
  }
}
